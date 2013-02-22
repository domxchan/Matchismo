//
//  SetCard.h
//  Matchismo
//
//  Created by Dominic Chan on 20/2/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) NSAttributedString *attrContents;
//+ (NSArray *) validNumbers;
+ (NSArray *) validSymbols;
+ (NSArray *) validShadings;
+ (NSArray *) validColors;
+ (NSUInteger) maxNumber;
@end
