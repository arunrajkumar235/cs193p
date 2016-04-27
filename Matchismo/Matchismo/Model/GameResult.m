//
//  GameResult.m
//  Matchismo
//
//  Created by Arun Rajkumar on 25/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import "GameResult.h"

#define ALL_RESULTS_KEY @"AllResults_Key"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"
#define GAME_KEY @"Game"

@interface GameResult()
@property (nonatomic, readwrite) NSDate *start;
@property (nonatomic, readwrite) NSDate *end;
@end



@implementation GameResult

- (NSTimeInterval)duration {
    return [self.end timeIntervalSinceDate:self.start];
}

- (void)setScore:(NSInteger)score {
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}

- (id)init {
    self = [super init];
    if(self) {
        _start = [NSDate date];
        _end = _start;
    }
    return self;
}

- (id)initFromPropertyList: (id)plist {
    self = [super init];
    if(self) {
        if([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] integerValue];
            _gameType = resultDictionary[GAME_KEY];
            if(!_start || !_end) {
                self = nil;
            }
        }
        
    }
    return self;
}

- (void)synchronize {
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    if(!mutableGameResultsFromUserDefaults) {
        mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    }
    mutableGameResultsFromUserDefaults[self.start.description] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)asPropertyList {
    return @{START_KEY: self.start, END_KEY: self.end, SCORE_KEY: @(self.score), GAME_KEY: self.gameType};
}

+ (NSArray *)allGameResults {
    NSMutableArray * allGameResults = [[NSMutableArray alloc] init];
    for(id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult *gameResult = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:gameResult];
    }
    return allGameResults;
}

- (NSComparisonResult)compareDate:(GameResult *)result
{
    return [self.end compare:result.end];
}

- (NSComparisonResult)compareScore:(GameResult *)result
{
    return [@(self.score) compare:@(result.score)];
}

- (NSComparisonResult)compareDuration:(GameResult *)result
{
    return [@(self.duration) compare:@(result.duration)];
}
@end
