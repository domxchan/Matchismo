//
//  GameStatusView.m
//  Matchismo
//
//  Created by Dominic Chan on 5/3/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "GameStatusView.h"
#import "SetCard.h"

@implementation GameStatusView

- (void)drawRect:(CGRect)rect
{
    CGRect textBounds;
    textBounds.origin = CGPointMake(0, 0);
    textBounds.size = [self.prefix size];
//    UILabel *prefixLabel = [[UILabel alloc] initWithFrame:textBounds];
//    prefixLabel.attributedText = self.prefix;
//    [prefixLabel drawTextInRect:textBounds];
    [self.prefix drawInRect:textBounds];
    [self drawMiniCards:CGPointMake(textBounds.origin.x+textBounds.size.width, textBounds.origin.y)];
    textBounds.origin = CGPointMake(0, self.postfix.size.height);
    textBounds.size = [self.postfix size];
//    UILabel *postfixLabel = [[UILabel alloc] initWithFrame:textBounds];
//    postfixLabel.attributedText = self.postfix;
//    [postfixLabel drawTextInRect:textBounds];
    [self.postfix drawInRect:textBounds];
}

- (CGFloat) drawMiniCards: (CGPoint) origin
{
    
    CGFloat miniCardHeight = [[UIFont systemFontOfSize:17] capHeight] * 2;
    CGFloat miniCardScaler = miniCardHeight / 8;
    CGFloat miniCardWidth;
    CGFloat offset = 0;
    CGFloat voffset = 0;
    
    for (SetCard *card in self.cards) {
        miniCardWidth = 2*(card.number)*miniCardScaler + (1+card.number)*miniCardScaler;
        
        SetCardView *lastFlippedMiniCard = [[SetCardView alloc] initWithFrame:CGRectMake(origin.x+offset, origin.y-voffset, miniCardWidth, miniCardHeight)];
        lastFlippedMiniCard.opaque = NO;
        lastFlippedMiniCard.backgroundColor = [UIColor clearColor];
        lastFlippedMiniCard.symbol = card.symbol;
        lastFlippedMiniCard.shading = card.shading;
        lastFlippedMiniCard.number = card.number;
        lastFlippedMiniCard.color = card.color;
        [self addSubview:lastFlippedMiniCard];
        offset += miniCardWidth + miniCardScaler;
    }
    return origin.x + offset;
}

- (void) setPrefix:(NSAttributedString *)prefix
{
    _prefix = prefix;
    [self setNeedsDisplay];
}

- (void) setPostfix:(NSAttributedString *)postfix
{
    _postfix = postfix;
    [self setNeedsDisplay];
}

- (void) setCards:(NSArray *)cards
{
    _cards = cards;
    [self setNeedsDisplay];
}


#pragma mark - Initialization

- (void) setup
{
    // do initialisation here
}

- (void) awakeFromNib
{
    [self setup];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.contentMode = UIViewContentModeRedraw;
    }
    return self;
}

@end
