//
//  PlayingCard.m
//  Matchismo
//
//  Created by Dominic Chan on 30/1/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;

    if ([otherCards count] == 1) {
        id otherCard = [otherCards lastObject];
        if ([otherCard isKindOfClass: [PlayingCard class]]) {
            PlayingCard *otherPlayingCard = (PlayingCard *)otherCard;
            if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                score = 1;
            } else if (otherPlayingCard.rank == self.rank) {
                score = 4;
            }
            
        }
    } else if ([otherCards count] == 2) {
        PlayingCard *card1 = otherCards[0];
        PlayingCard *card2 = otherCards[1];
        if ([card1.suit isEqualToString:self.suit] && [card2.suit isEqualToString:self.suit]) {
            score = 3;
        } else if (card1.rank == self.rank && card2.rank == self.rank) {
            score = 10;
        }
    }

    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *) validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (NSString *) description
{
    return self.contents;
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
