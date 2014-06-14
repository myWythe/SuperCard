//
//  Card.h
//  Machismo
//
//  Created by myqiqiang on 14-6-6.
//  Copyright (c) 2014年 myqiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong,nonatomic) NSString *contents;

@property (nonatomic,getter = isChosen) BOOL chosen;
@property (nonatomic,getter = isMatched) BOOL matched;

-(int)match:(NSArray *)othercards;

@end
