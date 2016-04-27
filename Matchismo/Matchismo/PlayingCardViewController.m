//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Arun Rajkumar on 19/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardViewController ()

@end

@implementation PlayingCardViewController

- (Deck *)createDeck {
    self.gameType = @"Playing Cards";
    return [[PlayingCardDeck alloc] init];
}


@end
