//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Dominic Chan on 19/2/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) SetCardDeck *deck;
@end

@implementation SetGameViewController

- (void) setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (SetCardDeck *) deck {
    if (!_deck) _deck = [[SetCardDeck alloc] init];
    return _deck;
}

- (void)addButtonAttributes: (NSDictionary *)attributes range:(NSRange) range cardButton:(UIButton*) cardButton state: (UIControlState) state
{
    if (range.location != NSNotFound) {
        NSMutableAttributedString *mat = [[cardButton attributedTitleForState:UIControlStateNormal] mutableCopy];
        [mat addAttributes:attributes range:range];
        [cardButton setAttributedTitle: mat forState: state];
    }
    
}

- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
//        Card *card = [self.cardButtons[[self.cardButtons indexOfObject:cardButton]]];
        SetCard *card = (SetCard *)[self.deck drawRandomCard];
        NSLog(@"card content: %@", card.contents);

//        NSString *titletext = card.contents;
//        NSDictionary *attributes = @{NSForegroundColorAttributeName: card.color,
//                                     NSFontAttributeName: [[cardButton attributedTitleForState:0] attributesAtIndex:0 effectiveRange:NULL][NSFontAttributeName],
//                                     NSStrokeWidthAttributeName: @-3,
//                                     NSStrokeColorAttributeName: card.color};
//        NSAttributedString *title = [[NSAttributedString alloc] initWithString:titletext attributes:attributes];
        [cardButton setAttributedTitle:card.attrContents forState:UIControlStateNormal];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1);
    }
}

@end
