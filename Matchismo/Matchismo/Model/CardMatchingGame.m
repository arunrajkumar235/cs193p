//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Arun Rajkumar on 13/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSInteger) score {
    if(!_score) _score=0;
    return _score;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init]; //super's initializer
    
    if(self) {
        for(int i=0;i<count;i++) {
            Card *card = [deck drawRandomCard];
            if(card) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *) cardAtIndex:(NSUInteger)index {
    return index < [self.cards count] ? [self.cards objectAtIndex:index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 2;

- (void) chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self.cards objectAtIndex:index];
    
    if(!card.isMatched) { //if card is chosen, unchoose it
        if(card.isChosen) {
            card.chosen = NO;
        }
        else {
            //match against other chosen cards
            for(Card *otherCard in self.cards) {
                if(otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    
                    if(matchScore > 0) {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    }
                    else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}
@end






























