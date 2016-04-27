//
//  HighScoresViewController.m
//  Matchismo
//
//  Created by Arun Rajkumar on 27/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "HighScoresViewController.h"
#import "GameResult.h"

@interface HighScoresViewController ()
@property (weak, nonatomic) IBOutlet UITextView *scoresTextView;
@property (nonatomic, strong) NSArray *scores;
@end

@implementation HighScoresViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.scores = [GameResult allGameResults];
    [self updateUI];
}

- (void)updateUI
{
    NSString *text = @"";
    for (GameResult *result in self.scores) {
        text = [text stringByAppendingString:[self stringFromResult:result]];
    }
    self.scoresTextView.text = text;
    NSArray *sortedScores = [self.scores sortedArrayUsingSelector:@selector(compareScore:)];
    [self changeScore:[sortedScores firstObject] toColor:[UIColor redColor]];
    [self changeScore:[sortedScores lastObject] toColor:[UIColor greenColor]];
    sortedScores = [self.scores sortedArrayUsingSelector:@selector(compareDuration:)];
    [self changeScore:[sortedScores firstObject] toColor:[UIColor purpleColor]];
    [self changeScore:[sortedScores lastObject] toColor:[UIColor blueColor]];
}

- (IBAction)touchSortByDate:(id)sender {
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareDate:)];
    [self updateUI];
}

- (IBAction)touchSortByScore:(id)sender {
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareScore:)];
    [self updateUI];
}

- (IBAction)touchSortByDuration:(id)sender {
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareDuration:)];
    [self updateUI];
}

- (NSString *)stringFromResult:(GameResult *)result
{
    return [NSString stringWithFormat:@"%@: %ld, (%@, %gs)\n",
            result.gameType,
            (long)result.score,
            [NSDateFormatter localizedStringFromDate:result.end
                                           dateStyle:NSDateFormatterShortStyle
                                           timeStyle:NSDateFormatterShortStyle],
            round(result.duration)];
}

- (void)changeScore:(GameResult *)result toColor:(UIColor *)color
{
    NSRange range = [self.scoresTextView.text rangeOfString:[self stringFromResult:result]];
    [self.scoresTextView.textStorage addAttribute:NSForegroundColorAttributeName
                                            value:color
                                            range:range];
}


@end
