//
//  PlayingCard.h
//  Machismo
//
//  Created by myqiqiang on 14-6-6.
//  Copyright (c) 2014年 myqiqiang. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong,nonatomic)NSString *suit;
@property (nonatomic)NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger)maxRank;

@end
