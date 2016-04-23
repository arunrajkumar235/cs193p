//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Arun Rajkumar on 22/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setHistoryText:(NSAttributedString *)historyText {
    _historyText = historyText;
    if(self.view.window) {
        [self updateUI];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI {
    [self.historyTextView setAttributedText:self.historyText];
}


@end
