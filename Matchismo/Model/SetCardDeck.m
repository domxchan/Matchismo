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
            for (NSUInteger j=0; j < [[SetCard validSymbols] count]; j++) {
                for (NSUInteger k=0; k < [[SetCard validShadings] count]; k++) {
                    for (NSUInteger l=0; l < [[SetCard validColors] count]; l++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = i;
                        card.symbol = j;
                        card.shading = k;
                        card.color = l;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
