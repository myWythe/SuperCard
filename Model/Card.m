//
//  Card.m
//  Machismo
//
//  Created by myqiqiang on 14-6-6.
//  Copyright (c) 2014年 myqiqiang. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

-(int)match:(NSArray *)othercards
{
    int score=0;
    for(Card *card in othercards)
        if([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    
    return score;

}

@end
