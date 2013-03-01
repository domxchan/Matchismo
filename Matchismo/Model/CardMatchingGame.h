//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Dominic Chan on 3/2/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
            playingMode:(NSUInteger) mode;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) int flipState; //1: matched,  -1: mismatch,  2: intermediate state
@property (readonly, nonatomic) NSArray *flippedCards; // working cards
@property (readonly, nonatomic) int scoreChange;
@property (nonatomic) int mode;  // 0: 2-card, 1: 3-card
@property (strong, nonatomic) NSString *gameName;

@end
