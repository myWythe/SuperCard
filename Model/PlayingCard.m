//
//  PlayingCard.m
//  Machismo
//
//  Created by myqiqiang on 14-6-6.
//  Copyright (c) 2014年 myqiqiang. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)othercards
{
    int score = 0;
    
    if([othercards count]==1){
        PlayingCard *otherCard = [othercards firstObject];
        if ([self.suit isEqualToString:otherCard.suit]) {
            score = 1;
        }
        else if (self.rank ==otherCard.rank){
            score = 4;
        }
    }
    
    return score;
}

-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings] ;
    return [rankStrings[self.rank] stringByAppendingString: self.suit];
}

@synthesize suit = _suit;

+(NSArray *)validSuits
{
    return @[@"♧",@"♢",@"♡",@"♤"];
}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

+(NSUInteger)maxRank
{
    return [[ self rankStrings] count]-1;
}

-(void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

@end
