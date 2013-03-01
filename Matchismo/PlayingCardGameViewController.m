//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Dominic Chan on 22/2/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface PlayingCardGameViewController ()
@property (strong, nonatomic) PlayingCardDeck *deck;
@end

@implementation PlayingCardGameViewController
- (NSString *) gameName {
    return @"Playing Card";
}

- (NSUInteger) playingMode {
    return 0;
}

- (PlayingCardDeck *) deck {
    return _deck? _deck: [[PlayingCardDeck alloc] init];
}

- (void) updateUI {
    UIImage *cardbackImage = [UIImage imageNamed:@"cardback2.png"];
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        
        UIImage *cardback = card.isFaceUp ? nil : cardbackImage;
        cardButton.imageEdgeInsets = UIEdgeInsetsMake(-60,-55,-60,-55);
        [cardButton setImage:cardback forState:UIControlStateNormal];
    }

    [super updateUI];
}

@end
