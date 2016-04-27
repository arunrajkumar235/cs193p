//
//  ViewController.m
//  Matchismo
//
//  Created by Arun Rajkumar on 11/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "HistoryViewController.h"
#import "GameSettings.h"


@interface ViewController ()
@property (nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *showHistoryBarButton;
@property (strong, nonatomic) GameSettings *gameSettings;
@end

@implementation ViewController

- (GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    _gameResult.gameType = self.gameType;
    return _gameResult;
}

- (GameSettings *)gameSettings
{
    if (!_gameSettings) _gameSettings = [[GameSettings alloc] init];
    return _gameSettings;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"Show History"]) {
        if([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
            
            NSMutableAttributedString *historyText = [[NSMutableAttributedString alloc] init];
            for(NSAttributedString *description in self.descriptionHistory) {
                if(historyText.length) {
                    [historyText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\r"]];
                }
                [historyText appendAttributedString:description];
            }
            
            hvc.navigationItem.title = @"History";
            //[hvc setHidesBottomBarWhenPushed: YES];
            hvc.historyText = historyText;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.flipDescription setText: @""];
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.game.matchBonus = self.gameSettings.matchBonus;
    self.game.mismatchPenalty = self.gameSettings.mismatchPenalty;
    self.game.flipCost = self.gameSettings.flipCost;
}

- (NSMutableArray *) descriptionHistory {
    if(!_descriptionHistory) _descriptionHistory = [[NSMutableArray alloc] init];
    return _descriptionHistory;
}

- (CardMatchingGame *) game {
    if(!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        _game.matchBonus = self.gameSettings.matchBonus;
        _game.mismatchPenalty = self.gameSettings.mismatchPenalty;
        _game.flipCost = self.gameSettings.flipCost;
    }
    return _game;
}
                    
- (Deck *)createDeck {
    return nil;
}

- (void) updateUI {
    for(UIButton * cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        [cardButton setEnabled:!card.isMatched];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
        self.gameResult.score = self.game.score;
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
        
        [self.descriptionHistory addObject: [[NSAttributedString alloc] initWithString:description]];
    }
    else {
        [self.descriptionHistory removeAllObjects];
    }
    
    
    self.flipDescription.text = description;
    
}
- (IBAction)changeHistorySlider:(UISlider *)sender {
    int index = floor(sender.value);
    NSUInteger descriptionCount = [self.descriptionHistory count];
    index = index >= descriptionCount ? (int)descriptionCount - 1 : index;
    if(index >= 0) {
        self.flipDescription.text = self.descriptionHistory[index];
    }
}

- (IBAction)touchRedeal:(UIButton *)sender {
    self.game = nil;
    self.gameResult = nil;
    [self updateUI];
}

- (NSString *)titleForCard: (Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard: (Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

@end
