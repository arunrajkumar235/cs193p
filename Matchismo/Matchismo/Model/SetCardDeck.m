//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Arun Rajkumar on 19/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    if(self) {
        for(NSUInteger number=1; number <= [SetCard maxNumber]; number++) {
            for(NSString *shading in [SetCard validShades]) {
                for(NSString *color in [SetCard validColors]) {
                    for(NSString *symbol in [SetCard validSymbols]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = number;
                        card.shading = shading;
                        card.color = color;
                        card.symbol = symbol;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}

@end
