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
@end

@implementation ViewController

- (CardMatchingGame *) game {
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck: [self createDeck]];
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
}

- (IBAction)touchMatchMode:(UISegmentedControl *)sender {
    
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
    //NSLog(@"chosenButtonIndex: %ld", chosenButtonIndex);
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

@end
