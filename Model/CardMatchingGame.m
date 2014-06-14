//
//  CardMatchingGame.m
//  Machismo
//
//  Created by myqiqiang on 14-6-6.
//  Copyright (c) 2014年 myqiqiang. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite,nonatomic)NSInteger score;
@property (strong,nonatomic)NSMutableArray *cards;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self=[super init];
    
    if(self){
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRadowCard];
            if(card){
                [self.cards addObject:card];
            }
            else{
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_MATCH =1;

-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card =[self cardAtIndex:index];
    
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
        }
        else{
            for (Card *otherCard in self.cards) {
                if(otherCard.isChosen && !otherCard.isMatched){
                    
                    int matchSocre = [card match:@[otherCard]];
                    if(matchSocre){
                        self.score += matchSocre*MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    }
                    else{
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_MATCH;
            card.chosen = YES;
        }
    }
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index]:nil;
}


@end
