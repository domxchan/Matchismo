//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Dominic Chan on 3/2/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Deck.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (readwrite, nonatomic) int flipState;
@property (readwrite, nonatomic) int scoreChange;
@property (readwrite, strong, nonatomic) NSArray *flippedCards; // of Card
@property (strong, nonatomic) Deck *deck;
@property (readwrite, strong, nonatomic) NSIndexSet *cardsIndexesToBeDeleted; // of card indexes

@property (strong, nonatomic) NSMutableArray *cards; // of Card.. Array can have anything in it.  annotating it with "Card" helps.
@end

@implementation CardMatchingGame
#define MATCH_BONUS 4
#define MISMATCH_PENALITY 2
#define FLIP_COST 1

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *otherCards = [[NSMutableArray alloc] init];
    NSMutableIndexSet *toBeDeletedIndexes = [[NSMutableIndexSet alloc] init];
    int matchScore = 0;
    self.flipState = nil;
    self.flippedCards = nil;
    
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {
            self.flipState = 2;

            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                    [toBeDeletedIndexes addIndex: [self.cards indexOfObject:otherCard]];
                }
            }

            if (((self.mode == 0) && ([otherCards count] == 1)) || ((self.mode == 1) && ([otherCards count] == 2)))  {
                matchScore = [card match:otherCards];

                if (matchScore) {
                    card.unplayable = YES;
                    for (Card *otherCard in otherCards) {
                        otherCard.unplayable = YES;
                    }
                    self.score += matchScore * MATCH_BONUS;
                    self.scoreChange = matchScore * MATCH_BONUS;
                    self.flipState = 1;
                    [toBeDeletedIndexes addIndex: index];
                    self.cardsIndexesToBeDeleted = toBeDeletedIndexes;
                } else {
//                    card.faceUp = YES;
                    for (Card *otherCard in otherCards) {
                        otherCard.faceUp = NO;
                    }
                    self.score -= MISMATCH_PENALITY;
                    self.scoreChange = MISMATCH_PENALITY;
                    self.flipState = -1;
                    [toBeDeletedIndexes removeAllIndexes];
                }
            } else {
                [toBeDeletedIndexes removeAllIndexes];
            }
            self.score -= FLIP_COST;
            self.flippedCards = [otherCards arrayByAddingObject:card];
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck playingMode:(NSUInteger)mode
{
    self = [super init];
    self.deck = deck;
    if (self) {
        self.mode = mode;
        for (int i=0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (void) deleteCards
{
    [self.cards removeObjectsAtIndexes: self.cardsIndexesToBeDeleted];
}

- (void) cleanUpCardIndexesToBeDeleted
{
    self.cardsIndexesToBeDeleted = [NSIndexSet indexSet];
}

- (void) addCards
{
    for (int i=0; i<3; i++) {
        Card *card = [self.deck drawRandomCard];
        if (card) [self.cards addObject:card];
    }
}

- (NSUInteger) numCardsInPlay
{
    __block NSUInteger numCards = 0;
    [self.cards enumerateObjectsUsingBlock:
     ^(Card *card, NSUInteger idx, BOOL *stop){
         if (!card.isUnplayable) {numCards++;}
     }];
    return numCards;
}

@end
