//
//  Deck.m
//  Machismo
//
//  Created by myqiqiang on 14-6-6.
//  Copyright (c) 2014年 myqiqiang. All rights reserved.
//

#import "Deck.h"

@interface Deck ()
@property (strong,nonatomic)NSMutableArray *cards;  //of cards

@end

@implementation Deck

-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if(atTop){
        [self.cards insertObject:card atIndex:0];
    }
    else{
        [self.cards addObject:card];
    }
}

-(void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

-(Card *)drawRadowCard
{
    Card *randowCard = nil;
    
    if([self.cards count]){
        unsigned index = arc4random() % [self.cards count];
        randowCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randowCard;
}

@end
