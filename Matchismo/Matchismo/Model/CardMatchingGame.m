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
@property (nonatomic, strong) NSArray *lastChosenCards;
@property (nonatomic, readwrite) NSInteger lastScore;
@end

@implementation CardMatchingGame

@synthesize cardMatchCount = _cardMatchCount;

- (NSUInteger) cardMatchCount {
    if(!_cardMatchCount) _cardMatchCount=2;
    return _cardMatchCount;
}

- (void) setCardMatchCount:(NSUInteger)cardMatchCount {
    if(cardMatchCount > 1 && cardMatchCount <= [self.cards count]) {
        _cardMatchCount = cardMatchCount;
    }
}

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
    NSMutableArray *otherCards = [[NSMutableArray alloc] init];
    
    if(!card.isMatched) {
        if(card.isChosen) { //if card is chosen, unchoose it
            card.chosen = NO;
        }
        else {
            //match against other chosen cards
            for(Card *otherCard in self.cards) {
                if(otherCard.isChosen && !otherCard.isMatched && otherCard != card) {
                    [otherCards addObject:otherCard];
                }
            }
            
            self.lastChosenCards = [otherCards arrayByAddingObject:card];
            self.lastScore = 0;
            
            if(otherCards.count == [self cardMatchCount]-1) {
                int matchScore = [card match:otherCards];
                
                if(matchScore > 0) {
                    self.lastScore += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for(Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                    }
                }
                else {
                    self.lastScore -= MISMATCH_PENALTY;
                    for(Card *otherCard in otherCards) {
                        otherCard.chosen = NO;
                    }
                }
            }
            
            self.score += self.lastScore - COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}
@end






























