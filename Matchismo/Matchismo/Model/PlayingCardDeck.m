//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Arun Rajkumar on 12/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        for(NSString *suit in [PlayingCard validSuits])
        {
            for(NSUInteger rank=1; rank<= [PlayingCard maxRank]; rank++)
            {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                //NSLog(@"%lu%@", (unsigned long)rank, suit);
                [self addCard:card];
            }
        }
        
    }
    return self;
}
@end
