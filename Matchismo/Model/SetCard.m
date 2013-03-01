//
//  SetCard.m
//  Matchismo
//
//  Created by Dominic Chan on 20/2/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 2) {
        BOOL cond1 = [self symbolsMatched: otherCards];
        BOOL cond2 = [self shadingsMatched: otherCards];
        BOOL cond3 = [self numbersMatched: otherCards];
        BOOL cond4 = [self colorsMatched: otherCards];
        if (cond1 && cond2 && cond3 && cond4) {
            score = 30;
        }
    }
    
    return score;
}

- (BOOL) symbolsMatched: (NSArray *) cards {
    BOOL matched = NO;
    if ([cards count] == 2) {
        NSString *string0 = self.symbol;
        NSString *string1 = ((SetCard *)cards[0]).symbol;
        NSString *string2 = ((SetCard *)cards[1]).symbol;
        matched = ([string0 isEqualToString:string1] && [string1 isEqualToString:string2]) || (![string0 isEqualToString:string1] && ![string1 isEqualToString:string2] && ![string0 isEqualToString:string2]);
    }
    return matched;
}

- (BOOL) shadingsMatched: (NSArray *) cards  {
    BOOL matched = NO;
    if ([cards count] == 2) {
        NSString *string0 = self.shading;
        NSString *string1 = ((SetCard *)cards[0]).shading;
        NSString *string2 = ((SetCard *)cards[1]).shading;
        matched = ([string0 isEqualToString:string1] && [string1 isEqualToString:string2]) || (![string0 isEqualToString:string1] && ![string1 isEqualToString:string2] && ![string0 isEqualToString:string2]);
    }
    return matched;
}

- (BOOL) numbersMatched: (NSArray *) cards  {
    BOOL matched = NO;
    if ([cards count] == 2) {
        NSUInteger num0 = self.number;
        NSUInteger num1 = ((SetCard *)cards[0]).number;
        NSUInteger num2 = ((SetCard *)cards[1]).number;
        matched = (num0 == num1 && num1 == num2) || (num0 != num1 && num1 != num2 && num0 != num2);
    }
    return matched;
}

- (BOOL) colorsMatched: (NSArray *) cards  {
    BOOL matched = NO;
    if ([cards count] == 2) {
        UIColor *col0 = self.color;
        UIColor *col1 = ((SetCard *)cards[0]).color;
        UIColor *col2 = ((SetCard *)cards[1]).color;
        matched = ([col0 isEqual: col1] && [col1 isEqual: col2]) || (![col0 isEqual: col1] && ![col1 isEqual: col2] && ![col0 isEqual: col2]);
    }
    return matched;
}

+ (NSUInteger) maxNumber {
    return 3;
}

- (void) setNumber:(NSUInteger) number {
    if (number <= [SetCard maxNumber] && number > 0) {
        _number = number;
    }
}

+ (NSArray *) validSymbols {
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *) validShadings {
    return @[@"solid", @"stripped", @"open"];
}

+ (NSArray *) validColors {
    return @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]];
}


- (NSString *) contents {
    NSString *text = [NSString stringWithFormat:@"%d%@/%@/%@", self.number, self.symbol,
                      self.shading, [self.color description]];
    return text;
}

- (NSString *) description
{
    return self.contents;
}
@end
