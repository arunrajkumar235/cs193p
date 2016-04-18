//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Arun Rajkumar on 18/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colourfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

- (void) setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textToAnalyze = textToAnalyze;
    if(self.view.window)  [self updateUI];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void) updateUI {
    self.colourfulCharactersLabel.text = [NSString stringWithFormat:@"%lu colourful characters", (unsigned long)[[self charactersWithAttribute:NSForegroundColorAttributeName] length] ];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%lu outlined characters", (unsigned long)[[self charactersWithAttribute:NSStrokeWidthAttributeName] length] ];
}

- (NSAttributedString *)charactersWithAttribute: (NSString *)attributeName {
    NSMutableAttributedString *matchingCharacters = [[NSMutableAttributedString alloc] init];
    int index=0;
    NSRange range;
    while(index<self.textToAnalyze.length){
        
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if(value) {
            [matchingCharacters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = (int)(range.location + range.length);
        }
        else {
            index++;
        }
        
    }
    return matchingCharacters;
}

@end
