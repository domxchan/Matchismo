//
//  Card.m
//  Matchismo
//
//  Created by Dominic Chan on 30/1/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;

    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

//- (int)match:(Card *)card
//{
//    int score = 0;
//    
//    if ([card.contents isEqualToString:self.contents]) {
//        score = 1;
//    }
//    return score;
//}
//
//@synthesize contents = _contents;
//@synthesize faceUp = _faceUp;
//@synthesize unplayable = _unplayable;
//
//- (NSString *) contents
//{
//    return _contents;
//}
//
//- (void)setContents:(NSString *)contents
//{
//    _contents = contents;
//}
//
//- (BOOL) isFaceUp
//{
//    return _faceUp;
//}
//
//- (void)setFaceUp:(BOOL)faceUp
//{
//    _faceUp = faceUp;
//}
//
//- (BOOL)isUnplayable
//{
//    return _unplayable;
//}
//
//- (void)setUnplayable:(BOOL)unplayable
//{
//    _unplayable = unplayable;
//}
//
@end
