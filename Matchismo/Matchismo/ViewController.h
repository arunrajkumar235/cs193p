//
//  ViewController.h
//  Matchismo
//
//  Created by Arun Rajkumar on 11/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *flipDescription;

@property (strong, nonatomic) NSMutableArray *descriptionHistory;

@end