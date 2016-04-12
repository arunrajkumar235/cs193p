//
//  PlayingCard.m
//  Matchismo
//
//  Created by Arun Rajkumar on 12/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] -1;
}

- (void)setRank: (NSUInteger)rank
{
    if(rank<[PlayingCard maxRank])
    {
        _rank = rank;
    }
}

- (NSString *) contents
{
    NSArray * rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString: self.suit];
}

@synthesize suit = _suit;
- (void) setSuit: (NSString *)suit
{
    if( [[PlayingCard validSuits] containsObject:suit ])
    {
        _suit = suit;
    }
}

+ (NSArray *)validSuits
{
    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}

- (NSString *) suit
{
    return _suit ? _suit : @"?";
}
@end
