//
//  PlayingCard.m
//  Matchismo
//
//  Created by Arun Rajkumar on 12/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int) match:(NSArray *)otherCards
{
    int score = 0;
    
    if([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if(otherCard.rank == self.rank) {
            score = 4;
        }
        else if(otherCard.suit == self.suit) {
            score = 1;
        }
    }
    else if ([otherCards count] == 2) {
        PlayingCard *otherCard1 = otherCards[0], *otherCard2 = otherCards[1];
        if(otherCard1.rank == self.rank) {
            score += 4;
        }
        if(otherCard1.suit == self.suit) {
            score += 1;
        }
        
        if(otherCard1.rank == otherCard2.rank) {
            score += 4;
        }
        if(otherCard1.suit == otherCard2.suit) {
            score += 1;
        }
        
        if(otherCard2.rank == self.rank) {
            score += 4;
        }
        if(otherCard2.suit == self.suit) {
            score += 1;
        }
    }
    
    return score;
}

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
    if(rank<=[PlayingCard maxRank] && rank>0)
    {
        _rank = rank;
    }
}

- (NSString *) contents
{
    NSArray * rankStrings = [PlayingCard rankStrings];
    NSString * tempContents = [rankStrings[self.rank] stringByAppendingString: self.suit];
    //NSLog(@"%@ - %lu", tempContents, self.rank);
    return tempContents;
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
