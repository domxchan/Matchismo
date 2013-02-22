//
//  SetCard.m
//  Matchismo
//
//  Created by Dominic Chan on 20/2/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSUInteger) maxNumber {
    return 3;
}

- (void) setNumber:(NSUInteger) number {
    if (number <= [SetCard maxNumber] && number > 0) {
        _number = number;
    }
}
//+ (NSArray *) validNumbers {
//    return @[@"one", @"two", @"three"];
//}

+ (NSArray *) validSymbols {
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *) validShadings {
    return @[@"solid", @"stripped", @"open"];
}

+ (NSArray *) validColors {
    return @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]];
}

- (NSAttributedString *)attrContents
{

    NSString *text = [@"" stringByPaddingToLength:self.number withString:self.symbol startingAtIndex:0];
    CGFloat alpha_val = 0.0;
    if ([self.shading isEqualToString:@"solid"]) {
        alpha_val = 1.0;
    } else if ([self.shading isEqualToString:@"stripped"]) {
        alpha_val = 0.15;
    }
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [self.color colorWithAlphaComponent: alpha_val],
                                 NSStrokeWidthAttributeName: @-5,
                                 NSStrokeColorAttributeName: self.color};
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    return attrText;
}

- (NSString *) contents {
    NSString *text = [self.attrContents description];
    return text;
}

- (NSString *) description
{
    return self.contents;
}
@end
