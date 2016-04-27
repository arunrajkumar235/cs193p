//
//  GameResult.h
//  Matchismo
//
//  Created by Arun Rajkumar on 25/04/16.
//  Copyright © 2016 Arunamritha Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+ (NSArray *)allGameResults;
@property (nonatomic, readonly) NSDate *start;
@property (nonatomic, readonly) NSDate *end;
@property (nonatomic, readonly) NSTimeInterval duration;
@property (nonatomic) NSInteger score;
@property (nonatomic, strong) NSString *gameType;
- (NSComparisonResult)compareDate:(GameResult *)result;
- (NSComparisonResult)compareScore:(GameResult *)result;
- (NSComparisonResult)compareDuration:(GameResult *)result;
@end
