//
//  GameResult.m
//  Matchismo
//
//  Created by Dominic Chan on 11/2/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()
@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;
@end

@implementation GameResult

#define ALL_RESULTS_KEY @"GameResult_All"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"
#define GAME_NAME @"GameName"

//comparator by date
- (NSComparisonResult)compareByDate:(GameResult *)result
{
    return [self.end compare:result.end];
}

//comparator by score
- (NSComparisonResult)compareByScore:(GameResult *)result
{
    return [ @(self.score) compare:@(result.score)];
}

//comparator by duration
- (NSComparisonResult)compareByDuration:(GameResult *)result
{
    return [@(self.duration) compare:@(result.duration)];
}

+ (NSArray *)allGameResults
{
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult *result = [[GameResult alloc] initFromPropertyList: plist];
        [allGameResults addObject:result];
    }
    return allGameResults;
}

// convenience initialiser
- (id)initFromPropertyList:(id)plist
{
    self = [self init];
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue];
            _gameName = resultDictionary[GAME_NAME];
            if (!_start || !_end) self = nil;
        }
    }
    return self;
}

- (void)synchronize
{
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    if (!mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)asPropertyList
{
    return @{ START_KEY: self.start, END_KEY: self.end, SCORE_KEY: @(self.score), GAME_NAME: self.gameName};
}

// designated initialiser
- (id) init
{
    self = [super init];
    if (self) {
        _start = [NSDate date];
        _end = _start;
        _gameName = [[NSString alloc] init];
    }
    return self;
}

- (NSTimeInterval)duration
{
    return [self.end timeIntervalSinceDate:self.start];
}

- (void)setScore:(int) score
{
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}

@end
