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
#import "SetCardCollectionViewCell.h"
#import "GameStatusView.h"

@interface SetGameViewController ()
@property (strong, nonatomic) SetCardDeck *deck;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation SetGameViewController
- (BOOL) gameWillRemoveMatchedCards
{
    return YES;
}

- (Deck *) createDeck {
    return self.deck;
}

- (NSUInteger) startingCardCount
{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SetCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card animated:NO];
    return cell;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card  animated:(BOOL)animated
{
    if ([cell isKindOfClass:[SetCardCollectionViewCell class]]) {
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setCardView;
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *setCard = (SetCard *) card;
            setCardView.number = setCard.number;
            setCardView.symbol = setCard.symbol;
            setCardView.shading = setCard.shading;
            setCardView.color = setCard.color;
            if (animated && setCardView.faceUp!=setCard.faceUp) {
                
                [UIView transitionWithView:setCardView
                                  duration:0.5
                                   options:UIViewAnimationOptionCurveEaseInOut
                                animations:^{
                                    setCardView.faceUp = setCard.faceUp;
                                }
                                completion:NULL];
                
            } else {
                setCardView.faceUp = setCard.faceUp;
            }
        }
    }
}


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
    NSString *text = [@"" stringByPaddingToLength:card.number withString:[SetCard validSymbols][card.symbol] startingAtIndex:0];
    CGFloat alpha_val = 0.0;
    if ([[SetCard validShadings][card.shading] isEqualToString:@"solid"]) {
        alpha_val = 1.0;
    } else if ([[SetCard validShadings][card.shading] isEqualToString:@"stripped"]) {
        alpha_val = 0.15;
    }
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [[SetCard validColors][card.color] colorWithAlphaComponent: alpha_val],
                                 NSStrokeWidthAttributeName: @-5,
                                 NSStrokeColorAttributeName: [SetCard validColors][card.color]};
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    return attrText;
}

- (void) updateUI {
//    for (UIButton *cardButton in self.cardButtons) {
//        SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
//        [cardButton setAttributedTitle:[self attrContents:card] forState:UIControlStateNormal];
//        cardButton.selected = card.isFaceUp;
//        cardButton.enabled = !card.isUnplayable;
//        cardButton.backgroundColor = cardButton.isSelected? [UIColor yellowColor] : [UIColor whiteColor];
//        cardButton.alpha = (card.isUnplayable ? 0.3 : 1);
//    }
    
    [super updateUI];

}

- (void) updateDesc
{
    self.descLabel.attributedText = nil;
    for (UIView *subview in self.mainView.subviews) {
        if ([subview isKindOfClass:[GameStatusView class]]) [subview removeFromSuperview];
    }

    GameStatusView *gameStatusView = [[GameStatusView alloc] initWithFrame:self.descLabel.frame];
    gameStatusView.opaque = NO;
    gameStatusView.backgroundColor = [UIColor clearColor];
    gameStatusView.cards = self.game.flippedCards;
    
    if (self.game.flipState == 2) {
        gameStatusView.prefix = [[NSAttributedString alloc] initWithString:@"Flipped up" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    } else if (self.game.flipState == 1) {
        gameStatusView.prefix = [[NSAttributedString alloc] initWithString:@"Matched" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}];
        gameStatusView.postfix = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat: @"for %d points", self.game.scoreChange] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    } else if (self.game.flipState == -1) {
        gameStatusView.postfix = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat: @"don't match! %d points penalty!", self.game.scoreChange] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    }

    if ([self.game.flippedCards count] > 0) {
        [gameStatusView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.mainView addSubview:gameStatusView];
        NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:gameStatusView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.descLabel
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1
                                                               constant:0];
        [self.mainView addConstraint: cn];
        cn = [NSLayoutConstraint constraintWithItem:gameStatusView
                                          attribute:NSLayoutAttributeLeft
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.descLabel
                                          attribute:NSLayoutAttributeLeft
                                         multiplier:1
                                           constant:0];
        [self.mainView addConstraint: cn];
        cn = [NSLayoutConstraint constraintWithItem:gameStatusView
                                          attribute:NSLayoutAttributeRight
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.descLabel
                                          attribute:NSLayoutAttributeRight
                                         multiplier:1
                                           constant:0];
        [self.mainView addConstraint: cn];
        cn = [NSLayoutConstraint constraintWithItem:gameStatusView
                                          attribute:NSLayoutAttributeBottom
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.descLabel
                                          attribute:NSLayoutAttributeBottom
                                         multiplier:1
                                           constant:0];
        [self.mainView addConstraint: cn];
        [gameStatusView setNeedsDisplay];
//        [self visualizeConstraints:[gameStatusView constraints]];
    }
}

//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    [self updateDesc];
//}

@end
