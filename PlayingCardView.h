//
//  PlayingCardView.h
//  SuperCard
//
//  Created by myqiqiang on 14-6-12.
//  Copyright (c) 2014年 myqiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic)NSUInteger rank;
@property (strong,nonatomic)NSString *suit;
@property (nonatomic)BOOL faceUp;

-(void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
