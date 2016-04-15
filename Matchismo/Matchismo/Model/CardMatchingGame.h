//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Arun Rajkumar on 13/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//Designated initializer
- (instancetype)initWithCardCount: (NSUInteger) count
                        usingDeck: (Deck *)deck;
- (void) chooseCardAtIndex: (NSUInteger) index;
- (Card *) cardAtIndex: (NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;
@end
