//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Arun Rajkumar on 19/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"

@interface PlayingCardViewController ()

@end

@implementation PlayingCardViewController

- (Deck *)createDeck {
    self.gameType = @"Playing Cards";
    return [[PlayingCardDeck alloc] init];
}

- (void)updateUI {
    for(PlayingCardView *pCardView in self.cardViews) {
        NSUInteger cardViewIndex = [self.cardViews indexOfObject:pCardView];
        PlayingCard *pCard = (PlayingCard *)[self.game cardAtIndex: cardViewIndex];
        [pCardView setRank:pCard.rank];
        [pCardView setSuit:pCard.suit];
        [pCardView setFaceUp:pCard.isChosen];
        //Add code to disable PlayingCard view
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
        self.gameResult.score = self.game.score;
    }
}

- (IBAction)touchRedeal:(UIButton *)sender {
    self.game = nil;
    self.gameResult = nil;
    [self updateUI];
}

@end
