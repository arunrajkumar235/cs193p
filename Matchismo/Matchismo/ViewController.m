//
//  ViewController.m
//  Matchismo
//
//  Created by Arun Rajkumar on 11/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeButton;
@property (weak, nonatomic) IBOutlet UILabel *flipDescription;
@end

@implementation ViewController

- (CardMatchingGame *) game {
    if(!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck: [self createDeck]];
        _game.cardMatchCount = self.matchModeButton.selectedSegmentIndex + 2;
    }
    return _game;
}
                    
- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (void) updateUI {
    for(UIButton * cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        [cardButton setEnabled:!card.isMatched];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    }
    
    NSString *description = @"";
    if(self.game.lastChosenCards.count) {
        NSMutableArray *cardContents = [[NSMutableArray alloc] init];
        for(Card *card in self.game.lastChosenCards) {
            [cardContents addObject:card.contents];
        }
        description = [cardContents componentsJoinedByString:@" "];
        
        if(self.game.lastScore>0) {
            description = [NSString stringWithFormat:@"Matched %@ for %lu points.", description, self.game.lastScore];
        }
        else if(self.game.lastScore<0) {
            description = [NSString stringWithFormat:@"%@ don't match. %lu point penalty!", description, -self.game.lastScore];
        }
    }
    
    self.flipDescription.text = description;
    
}
- (IBAction)touchMatchMode:(UISegmentedControl *)sender {
    _game = nil;
}

- (IBAction)touchRedeal:(UIButton *)sender {
    _game = nil;
    [self updateUI];
    self.matchModeButton.enabled = YES;
}

- (NSString *)titleForCard: (Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard: (Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.matchModeButton.enabled = NO;
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

@end
