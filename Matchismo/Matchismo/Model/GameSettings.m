//
//  GameSettings.m
//  Matchismo
//
//  Created by Arun Rajkumar on 23/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "GameSettings.h"
#define GAME_SETTINGS_KEY @"Game_Settings_Key"
#define MATCH_BONUS_KEY @"MatchBonus_Key"
#define MISMATCH_PENALTY_KEY @"MismatchPenalty_Key"
#define FLIP_COST_KEY @"FlipCost_Key"

@implementation GameSettings
@synthesize matchBonus = _matchBonus;
@synthesize mismatchPenalty = _mismatchPenalty;
@synthesize flipCost = _flipCost;

- (int)intValueForKey: (NSString *)key withDefault: (int)defaultValue {
    NSDictionary *settings = [[NSUserDefaults standardUserDefaults] dictionaryForKey:GAME_SETTINGS_KEY];
    if(!settings) return defaultValue;
    if(![[settings allKeys] containsObject:key]) return defaultValue;
    return [settings[key] intValue];
}

- (int)matchBonus {
    return [self intValueForKey:MATCH_BONUS_KEY withDefault:4];
}

- (int)mismatchPenalty {
    return [self intValueForKey:MISMATCH_PENALTY_KEY withDefault:2];
}

- (int)flipCost {
    return [self intValueForKey:FLIP_COST_KEY withDefault:2];
}

- (void)setIntValueForKey: (NSString *)key value: (int)value{
    NSMutableDictionary *settings = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:GAME_SETTINGS_KEY] mutableCopy];
    if(!settings) {
        settings = [[NSMutableDictionary alloc] init];
    }
    settings[key] = @(value);
    [[NSUserDefaults standardUserDefaults] setObject:settings forKey:GAME_SETTINGS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setMatchBonus:(int)matchBonus {
    [self setIntValueForKey:MATCH_BONUS_KEY value:matchBonus];
}

- (void)setMismatchPenalty:(int)mismatchPenalty {
    [self setIntValueForKey:MISMATCH_PENALTY_KEY value:mismatchPenalty];
}

- (void)setFlipCost:(int)flipCost {
    [self setIntValueForKey:FLIP_COST_KEY value:flipCost];
}


@end
