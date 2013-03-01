//
//  GameResult.h
//  Matchismo
//
//  Created by Dominic Chan on 11/2/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+ (NSArray *)allGameResults; // of GameResult

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *gameName;

- (NSComparisonResult)compareByDate:(GameResult *)result;
- (NSComparisonResult)compareByScore:(GameResult *)result;
- (NSComparisonResult)compareByDuration:(GameResult *)result;
@end
