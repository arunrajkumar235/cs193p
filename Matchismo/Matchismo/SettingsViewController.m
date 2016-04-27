//
//  SettingsViewController.m
//  Matchismo
//
//  Created by Arun Rajkumar on 23/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "SettingsViewController.h"
#import "GameSettings.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISlider *matchBonusSlider;
@property (weak, nonatomic) IBOutlet UISlider *mismatchPenaltySlider;
@property (weak, nonatomic) IBOutlet UISlider *flipCostSlider;

@property (weak, nonatomic) IBOutlet UILabel *matchBonusLabel;
@property (weak, nonatomic) IBOutlet UILabel *mismatchPenaltyLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipCostLabel;

@property (nonatomic, strong) GameSettings *gameSettings;
@end

@implementation SettingsViewController

- (GameSettings *)gameSettings {
    if(!_gameSettings) _gameSettings = [[GameSettings alloc] init];
    return _gameSettings;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.matchBonusSlider.value = self.gameSettings.matchBonus;
    self.mismatchPenaltySlider.value = self.gameSettings.mismatchPenalty;
    self.flipCostSlider.value = self.gameSettings.flipCost;
    [self setLabel:self.matchBonusLabel forSlider:self.matchBonusSlider];
    [self setLabel:self.mismatchPenaltyLabel forSlider:self.mismatchPenaltySlider];
    [self setLabel:self.flipCostLabel forSlider:self.flipCostSlider];
}

- (void)setLabel: (UILabel *)label forSlider: (UISlider *)slider {
    int sliderValue = (int)floor(slider.value);
    label.text = [NSString stringWithFormat:@"%d", sliderValue];
}

- (IBAction)slideMatchBonus:(UISlider *)sender {
    [self setLabel:self.matchBonusLabel forSlider:sender];
    self.gameSettings.matchBonus = floor(sender.value);
}

- (IBAction)slideMismatchPenalty:(UISlider *)sender {
    [self setLabel:self.mismatchPenaltyLabel forSlider:sender];
    self.gameSettings.mismatchPenalty = floor(sender.value);
}

- (IBAction)slideFlipCost:(UISlider *)sender {
    [self setLabel:self.flipCostLabel forSlider:sender];
    self.gameSettings.flipCost = floor(sender.value);
}

@end
