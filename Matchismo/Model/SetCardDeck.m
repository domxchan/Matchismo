//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Dominic Chan on 20/2/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    
    if (self) {
        for (NSUInteger i=1; i <= [SetCard maxNumber]; i++) {
            for (NSString *symbol in [SetCard validSymbols]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (UIColor *color in [SetCard validColors]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.Number = i;
                        card.Symbol = symbol;
                        card.Shading = shading;
                        card.Color = color;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
