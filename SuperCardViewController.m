//
//  SuperCardViewController.m
//  SuperCard
//
//  Created by myqiqiang on 14-6-12.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "SuperCardViewController.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface SuperCardViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (strong,nonatomic)Deck *deck;

@end

@implementation SuperCardViewController

-(Deck *)deck
{
    if(!_deck)
        _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

-(void)drawRadowPlayingCard
{
    Card *card = [self.deck drawRadowCard];
    if([card isKindOfClass:[PlayingCard class]]){
        PlayingCard *playCard = (PlayingCard *)card;
        self.playingCardView.rank = playCard.rank;
        self.playingCardView.suit = playCard.suit;
    }
}
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender
{
    if(!self.playingCardView.faceUp)
        [self drawRadowPlayingCard];
    self.playingCardView.faceUp = !self.playingCardView.faceUp;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.playingCardView.suit = @"♡";
    self.playingCardView.rank = 13;
    [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView action:@selector(pinch:)]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
