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
        BOOL cond1 = [self foundMatches:[@[[NSNumber numberWithUnsignedInt:self.number]] arrayByAddingObjectsFromArray:[otherCards valueForKey:@"number"]]];
        BOOL cond2 = [self foundMatches:[@[[NSNumber numberWithUnsignedInt:self.symbol]] arrayByAddingObjectsFromArray:[otherCards valueForKey:@"symbol"]]];
        BOOL cond3 = [self foundMatches:[@[[NSNumber numberWithUnsignedInt:self.shading]] arrayByAddingObjectsFromArray:[otherCards valueForKey:@"shading"]]];
        BOOL cond4 = [self foundMatches:[@[[NSNumber numberWithUnsignedInt:self.color]] arrayByAddingObjectsFromArray:[otherCards valueForKey:@"color"]]];

//        NSLog(@"number: %@", [@[[NSNumber numberWithUnsignedInt:self.number]] arrayByAddingObjectsFromArray:[otherCards valueForKey:@"number"]]);
//        NSLog(@"symbol: %@", [@[[NSNumber numberWithUnsignedInt:self.symbol]] arrayByAddingObjectsFromArray:[otherCards valueForKey:@"symbol"]]);
//        NSLog(@"shading: %@", [@[[NSNumber numberWithUnsignedInt:self.shading]] arrayByAddingObjectsFromArray:[otherCards valueForKey:@"shading"]]);
//        NSLog(@"color: %@", [@[[NSNumber numberWithUnsignedInt:self.color]] arrayByAddingObjectsFromArray:[otherCards valueForKey:@"color"]]);
        if (cond1 && cond2 && cond3 && cond4) {
            score = 30;
        }
    }
    
    return score;
}

- (BOOL) foundMatches: (NSArray *) cardContents
{
    BOOL matched = NO;
    if ([cardContents count] == 3) {
        NSUInteger num0 = cardContents[0];
        NSUInteger num1 = cardContents[1];
        NSUInteger num2 = cardContents[2];
        matched = (num0 == num1 && num1 == num2) || (num0 != num1 && num1 != num2 && num0 != num2);
    }
    return matched;
}

//- (BOOL) numbersMatched: (NSArray *) cards  {
//    BOOL matched = NO;
//    if ([cards count] == 2) {
//        NSUInteger num0 = self.number;
//        NSUInteger num1 = ((SetCard *)cards[0]).number;
//        NSUInteger num2 = ((SetCard *)cards[1]).number;
//        matched = (num0 == num1 && num1 == num2) || (num0 != num1 && num1 != num2 && num0 != num2);
//    }
//    return matched;
//}
//
//- (BOOL) symbolsMatched: (NSArray *) cards {
//    BOOL matched = NO;
//    if ([cards count] == 2) {
//        NSString *string0 = self.symbol;
//        NSString *string1 = ((SetCard *)cards[0]).symbol;
//        NSString *string2 = ((SetCard *)cards[1]).symbol;
//        matched = ([string0 isEqualToString:string1] && [string1 isEqualToString:string2]) || (![string0 isEqualToString:string1] && ![string1 isEqualToString:string2] && ![string0 isEqualToString:string2]);
//    }
//    return matched;
//}
//
//- (BOOL) shadingsMatched: (NSArray *) cards  {
//    BOOL matched = NO;
//    if ([cards count] == 2) {
//        NSString *string0 = self.shading;
//        NSString *string1 = ((SetCard *)cards[0]).shading;
//        NSString *string2 = ((SetCard *)cards[1]).shading;
//        matched = ([string0 isEqualToString:string1] && [string1 isEqualToString:string2]) || (![string0 isEqualToString:string1] && ![string1 isEqualToString:string2] && ![string0 isEqualToString:string2]);
//    }
//    return matched;
//}
//
//- (BOOL) colorsMatched: (NSArray *) cards  {
//    BOOL matched = NO;
//    if ([cards count] == 2) {
//        UIColor *col0 = self.color;
//        UIColor *col1 = ((SetCard *)cards[0]).color;
//        UIColor *col2 = ((SetCard *)cards[1]).color;
//        matched = ([col0 isEqual: col1] && [col1 isEqual: col2]) || (![col0 isEqual: col1] && ![col1 isEqual: col2] && ![col0 isEqual: col2]);
//    }
//    return matched;
//}

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

- (void) setSymbol:(NSUInteger)symbol {
    if (symbol < [[SetCard validSymbols] count]) {
        _symbol = symbol;
    }
}

+ (NSArray *) validShadings {
    return @[@"solid", @"stripped", @"open"];
}

- (void) setShading:(NSUInteger)shading {
    if (shading < [[SetCard validShadings] count]) {
        _shading = shading;
    }
}

+ (NSArray *) validColors {
    return @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]];
}

- (void) setColor:(NSUInteger)color {
    if (color < [[SetCard validColors] count]) {
        _color = color;
    }
}

- (NSString *) contents {
    NSString *text = [NSString stringWithFormat:@"%d%@/%@/%@",
                      self.number,
                      [SetCard validSymbols][self.symbol],
                      [SetCard validShadings][self.shading],
                      [[SetCard validColors][self.color] description]];
    return text;
}

- (NSString *) description
{
    return self.contents;
}
@end
