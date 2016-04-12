//
//  PlayingCard.h
//  Matchismo
//
//  Created by Arun Rajkumar on 12/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "card.h"

@interface PlayingCard : Card

@property (nonatomic, strong) NSString * suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end
