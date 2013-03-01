//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Dominic Chan on 19/2/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"

@interface SetGameViewController ()
@property (strong, nonatomic) SetCardDeck *deck;
@end

@implementation SetGameViewController
- (NSString *) gameName {
    return @"Set Card";
}

- (NSUInteger) playingMode {
    return 1;
}

- (SetCardDeck *) deck {
    return _deck? _deck :[[SetCardDeck alloc] init];
}

- (NSAttributedString *)attrContents: (SetCard *) card {
    NSString *text = [@"" stringByPaddingToLength:card.number withString:card.symbol startingAtIndex:0];
    CGFloat alpha_val = 0.0;
    if ([card.shading isEqualToString:@"solid"]) {
        alpha_val = 1.0;
    } else if ([card.shading isEqualToString:@"stripped"]) {
        alpha_val = 0.15;
    }
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [card.color colorWithAlphaComponent: alpha_val],
                                 NSStrokeWidthAttributeName: @-5,
                                 NSStrokeColorAttributeName: card.color};
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    return attrText;
}

- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setAttributedTitle:[self attrContents:card] forState:UIControlStateNormal];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.backgroundColor = cardButton.isSelected? [UIColor yellowColor] : [UIColor whiteColor];
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1);
    }
    
    [super updateUI];
}

@end
