//
//  ChatViewController.m
//  Matchismo
//
//  Created by Arun Rajkumar on 26/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "ChatViewController.h"
#import "HotlineSDK/Hotline.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[[Hotline sharedInstance] showConversations:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[Hotline sharedInstance] showConversations:self];
}

@end
