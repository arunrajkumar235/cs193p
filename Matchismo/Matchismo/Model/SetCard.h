//
//  SetCard.h
//  Matchismo
//
//  Created by Arun Rajkumar on 19/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (nonatomic, strong) NSString * symbol;
@property (nonatomic, strong) NSString * shading;
@property (nonatomic, strong) NSString * color;

+ (NSUInteger) maxNumber;
+ (NSArray *) validSymbols;
+ (NSArray *) validShades;
+ (NSArray *) validColors;

@end
