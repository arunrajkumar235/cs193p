//
//  SetViewController.m
//  Matchismo
//
//  Created by Arun Rajkumar on 19/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "SetViewController.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.game.cardMatchCount = 3;
    [self updateUI];
}

- (Deck *)createDeck {
    self.gameType = @"Set Cards";
    return [[SetCardDeck alloc] init];
}



- (NSAttributedString *)titleForCard: (Card *)card {
    SetCard *setCard = (SetCard *)card;
    NSString *title = [[NSString alloc] init];
    for(NSUInteger count=1; count<=setCard.number; count++) {
        title = [title stringByAppendingString:setCard.symbol];
    }
    
    NSMutableDictionary *attrDict = [[NSMutableDictionary alloc] init];
    if([setCard.color isEqualToString: @"red"]) {
        [attrDict setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    }
    else if([setCard.color isEqualToString: @"green"]) {
        [attrDict setObject:[UIColor greenColor] forKey:NSForegroundColorAttributeName];
    }
    else if([setCard.color isEqualToString: @"blue"]) {
        [attrDict setObject:[UIColor blueColor] forKey:NSForegroundColorAttributeName];
    }
    
    if([setCard.shading isEqualToString: @"open"]) {
        [attrDict addEntriesFromDictionary: @{NSStrokeWidthAttributeName: @3,
                                              NSStrokeColorAttributeName: attrDict[NSForegroundColorAttributeName]}];
    }
    else if([setCard.shading isEqualToString: @"striped"]) {
        [attrDict addEntriesFromDictionary: @{NSStrokeWidthAttributeName: @-3,
                                              NSStrokeColorAttributeName: attrDict[NSForegroundColorAttributeName],
                                              NSForegroundColorAttributeName: [(UIColor *)(attrDict[NSForegroundColorAttributeName]) colorWithAlphaComponent:0.25] }];
        
    }
    
    
    
    NSAttributedString *titleAttrStr = [[NSAttributedString alloc] initWithString: title  attributes: attrDict];
    
    return titleAttrStr;
}

- (void) updateUI {
    for(UIButton * cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        if(card.isChosen){
            [cardButton setBackgroundColor:[UIColor yellowColor]];
            [cardButton setBackgroundImage:nil forState:UIControlStateNormal];
        }
        else {
            [cardButton setBackgroundColor:[UIColor whiteColor]];
            [cardButton setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
        }
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setEnabled:!card.isMatched];
        if(card.isMatched) {
            [cardButton setBackgroundColor:[UIColor lightGrayColor]];
            [cardButton setBackgroundImage:nil forState:UIControlStateNormal];
        }
        
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    self.gameResult.score = self.game.score;
    
    NSMutableAttributedString *description = [[NSMutableAttributedString alloc] init];
    if(self.game.lastChosenCards.count) {
        NSAttributedString *delimiter = [[NSAttributedString alloc] initWithString:@" "];
        for(SetCard *setCard in self.game.lastChosenCards) {
            if(description.length) {
                [description appendAttributedString:delimiter];
            }
            [description appendAttributedString:[self titleForCard:setCard]];
        }
        
        NSMutableAttributedString *str1=nil, *str2=nil;
        
        NSMutableAttributedString *resultDescription = [[NSMutableAttributedString alloc] init];
        if(self.game.lastScore > 0) {
            str1 = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
            str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" for %lu points.", self.game.lastScore]];
            [resultDescription appendAttributedString:str1];
            [resultDescription appendAttributedString:description];
            [resultDescription appendAttributedString:str2];
        }
        else if(self.game.lastScore<0){
            str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match. %lu point penalty!", -self.game.lastScore] ];
            
            [resultDescription appendAttributedString:description];
            [resultDescription appendAttributedString:str1];
        }
        if(resultDescription.length) {
            [description setAttributedString:resultDescription];
        }
        
        [self.descriptionHistory addObject:description];
    }
    else {
        [self.descriptionHistory removeAllObjects];
    }
    
    [self.flipDescription setAttributedText:description];
}

- (IBAction)touchRedeal:(UIButton *)sender {
    self.game = nil;
    self.game.cardMatchCount = 3;
    self.gameResult = nil;
    [self updateUI];
}

@end
