//
//  PlayingCardView.m
//  SuperCard
//
//  Created by myqiqiang on 14-6-12.
//  Copyright (c) 2014年 myqiqiang. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView ()

@property (nonatomic) CGFloat faceCardScaleFacter;

@end
@implementation PlayingCardView

@synthesize faceCardScaleFacter = _faceCardScaleFacter;

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.9
-(CGFloat)faceCardScaleFacter
{
    if(!_faceCardScaleFacter)
        _faceCardScaleFacter = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFacter;
}

-(void)setFaceCardScaleFacter:(CGFloat)faceCardScaleFacter
{
    _faceCardScaleFacter = faceCardScaleFacter;
    [self setNeedsDisplay];
}
-(void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

-(void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

-(void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged)|| (gesture.state == UIGestureRecognizerStateEnded)){
        self.faceCardScaleFacter *= gesture.scale;
        gesture.scale = 1.0;
    }
}

#define CORNER_FONT_STANDARD_HEIGHT 182.0
#define CORNER_RADIUS 12.0

-(CGFloat)cornerScaleFacter {return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;}
-(CGFloat)cornerRadius {return CORNER_RADIUS * [self cornerScaleFacter];}
-(CGFloat)cornerOffset {return [self cornerRadius] / 3.0;}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectClip(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundRect stroke];
    if(self.faceUp){
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",[self rankAsString],self.suit]];
        if(faceImage){
            CGRect imageRect = CGRectInset(self.bounds,
                                             self.bounds.size.width * (1.0-self.faceCardScaleFacter),
                                             self.bounds.size.height * (1.0-self.faceCardScaleFacter));
            [faceImage drawInRect:imageRect];
        }else{
            [self drawPips];
        }
        
        [self drawCorners];
    }else{
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    }
}

#define PIP_HOFSET_PERCENTAGE 0.165
#define PIP_VOFSET1_PERCENTAGE 0.090
#define PIP_VOFSET2_PERCENTAGE 0.175
#define PIP_VOFSET3_PERCENTAGE 0.270

-(void)drawPips
{
    if ((self.rank == 1) || (self.rank ==5) || (self.rank ==9) || (self.rank ==3)) {
        [self drawPipsWithHorizonOffset:0
                         verticalOffset:0
                      mirroreVertically:NO];
    }
    if ((self.rank == 6) || (self.rank == 7) || (self.rank == 8 )) {
        [self drawPipsWithHorizonOffset:PIP_HOFSET_PERCENTAGE
                         verticalOffset:0
                      mirroreVertically:NO];
    }
    if ((self.rank == 2) || (self.rank == 3) || (self.rank == 7) || (self.rank ==8) || (self.rank ==10)) {
        [self drawPipsWithHorizonOffset:0
                         verticalOffset:PIP_VOFSET2_PERCENTAGE
                      mirroreVertically:(self.rank != 7)];
    }
    if ((self.rank == 4) || (self.rank == 5) || (self.rank ==6) || (self.rank == 7) || (self.rank == 8) || (self.rank ==9) || (self.rank == 10)) {
        [self drawPipsWithHorizonOffset:PIP_HOFSET_PERCENTAGE
                         verticalOffset:PIP_VOFSET3_PERCENTAGE
                      mirroreVertically:YES];
    }
    if ((self.rank == 9) || (self.rank ==10)) {
        [self drawPipsWithHorizonOffset:PIP_HOFSET_PERCENTAGE
                         verticalOffset:PIP_VOFSET1_PERCENTAGE
                      mirroreVertically:YES];
    }
}

#define PIP_FONR_SCALE_FACTOR 0.012

-(void)drawPipsWithHorizonOffset:(CGFloat)hoffset
                  vetticalOffset:(CGFloat)voffset
                      upsideDown:(BOOL)upsideDown
{
    if (upsideDown) [self pushContextAndRotateUpsideDown];
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    UIFont *pipfont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    pipfont = [pipfont fontWithSize:[pipfont pointSize] *self.bounds.size.width * PIP_FONR_SCALE_FACTOR];
    NSAttributedString *attributeSuit = [[NSAttributedString alloc] initWithString:self.suit attributes:@{NSFontAttributeName:pipfont}];
    CGSize pipSize = [attributeSuit size];
    CGPoint pipOrigin = CGPointMake(middle.x-pipSize.width/2.0-hoffset*self.bounds.size.width,
                                    middle.y-pipSize.height/2.0-voffset*self.bounds.size.height
                                    );
    [attributeSuit drawAtPoint:pipOrigin];
    if (hoffset) {
        pipOrigin.x += hoffset*2.0*self.bounds.size.width;
        [attributeSuit drawAtPoint:pipOrigin];
    }
    if (upsideDown) {
        [self popContext];
    }
}

-(void)drawPipsWithHorizonOffset:(CGFloat)hoffset
                 verticalOffset:(CGFloat)voffset
              mirroreVertically:(BOOL)mirroreVertically
{
    [self drawPipsWithHorizonOffset:hoffset
                     vetticalOffset:voffset
                         upsideDown:NO];
    if (mirroreVertically) {
        [self drawPipsWithHorizonOffset:hoffset
                         vetticalOffset:voffset
                             upsideDown:YES];
    }
}
-(void)pushContextAndRotateUpsideDown
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

-(void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

-(NSString *)rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

-(void)drawCorners
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFacter]];
    
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",[self rankAsString],self.suit] attributes:@{NSFontAttributeName : cornerFont,NSParagraphStyleAttributeName:paragraphStyle}];
    
    CGRect textBounds;
    textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    textBounds.size = [cornerText size];
    [cornerText drawInRect:textBounds];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    
    
    
    [cornerText drawInRect:textBounds];
}

-(void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

-(void)awakeFromNib
{
    [self setup];
}

@end
