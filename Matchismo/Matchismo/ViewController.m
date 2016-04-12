//
//  ViewController.m
//  Matchismo
//
//  Created by Arun Rajkumar on 11/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) Deck *deck;
@end

@implementation ViewController

- (Deck *) deck
{
    if(!_deck)
    {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

- (void) setFlipCount:(int)flipCount
{
    _flipCount=flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCount changed to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    PlayingCard * randomPlayingCard = (PlayingCard *)[self.deck drawRandomCard];
    
    [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                      forState: UIControlStateNormal];
    [sender setTitle:randomPlayingCard.contents forState:UIControlStateNormal];
    
    self.flipCount++;
}

@end
