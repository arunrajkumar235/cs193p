//
//  SetCard.m
//  Matchismo
//
//  Created by Arun Rajkumar on 19/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

//todo: implement this method

- (BOOL)isSetOf: (NSArray *)setCards matchAgainst: (NSArray *)criteria for: (NSString *)property {
    BOOL isSet = NO;
    
    NSMutableDictionary *criteriaDict = [[NSMutableDictionary alloc] init];
    
    if([property isEqualToString:@"number"]) {
        NSMutableArray *numbCriteria = [[NSMutableArray alloc] init];
        for(NSInteger i=1;i<=[SetCard maxNumber];i++) {
            [numbCriteria addObject:@(i)];
        }
        criteria = numbCriteria;
    }
    
    for(NSString *criterion in criteria) {
        [criteriaDict setValue:@0 forKey:criterion];
    }
    
    for(SetCard *setCard in setCards) {
        [criteriaDict setValue:@1 forKey:[setCard valueForKey:property]];
    }
    
    NSInteger setCount = 0;
    for(id key in criteriaDict) {
        NSInteger value = [[criteriaDict objectForKey:key] integerValue];
        setCount += value;
    }
    
    if(setCount == 1 || setCount == criteriaDict.count) {
        isSet = YES;
    }
    
    return isSet;
}

- (int)match: (NSArray *)otherCards {
    NSMutableArray *allCards = [[NSMutableArray alloc] initWithArray:otherCards];
    [allCards addObject:self];
    BOOL isSet = [self isSetOf:allCards matchAgainst:nil for:@"number"] && [self isSetOf:allCards matchAgainst:[SetCard validSymbols] for:@"symbol"] && [self isSetOf:allCards matchAgainst:[SetCard validColors] for: @"color"] && [self isSetOf:allCards matchAgainst:[SetCard validShades] for:@"shading"];
    return isSet?1:0;
}

- (void)setNumber:(NSUInteger)number {
    if(number <= [SetCard maxNumber] && number > 0) {
        _number = number;
    }
}

- (void)setSymbol:(NSString *)symbol {
    if( [[SetCard validSymbols] containsObject:symbol] ) {
        _symbol = symbol;
    }
}

- (void)setShading:(NSString *)shading {
    if( [[SetCard validShades] containsObject:shading] ) {
        _shading = shading;
    }
}

- (void)setColor:(NSString *)color {
    if( [[SetCard validColors] containsObject:color] ) {
        _color = color;
    }
}

+ (NSArray *)validSymbols {
    return @[@"▲", @"●", @"◼︎"];
}

+ (NSArray *)validShades {
    return @[@"solid", @"striped", @"open"];
}

+ (NSArray *)validColors {
    return @[@"red", @"blue", @"green"];
}

+ (NSUInteger)maxNumber {
    return 3;
}

@end
