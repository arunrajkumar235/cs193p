//
//  Deck.h
//  Matchismo
//
//  Created by Arun Rajkumar on 12/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "card.h"

@interface Deck : NSObject

- (void) addCard:(Card *)card atTop:(BOOL)atTop;
- (void) addCard:(Card *)card;
- (Card *) drawRandomCard;

@end
