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
#import "PlayingCardCollectionViewCell.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()
@property (strong, nonatomic) PlayingCardDeck *deck;
@end

@implementation PlayingCardGameViewController
- (BOOL) gameWillRemoveMatchedCards
{
    return NO;
}

- (Deck *) createDeck {
    return self.deck;
}

- (NSUInteger) startingCardCount
{
    return 22;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card animated:NO];
    return cell;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animated:(BOOL)animated
{
    if ([cell isKindOfClass:[PlayingCardCollectionViewCell class]]) {
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *playingCard = (PlayingCard *) card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            if (animated && playingCardView.faceUp!=playingCard.faceUp) {

                [UIView transitionWithView:playingCardView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft
                                animations:^{
                                    playingCardView.faceUp = playingCard.faceUp;
                                }
                                completion:NULL];
                
            } else {
                playingCardView.faceUp = playingCard.faceUp;                
            }
            playingCardView.alpha = playingCard.isUnplayable ? 0.3 : 1.0;
        }
    }
}

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
//    UIImage *cardbackImage = [UIImage imageNamed:@"cardback2.png"];
//    
//    for (UIButton *cardButton in self.cardButtons) {
//        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
//        [cardButton setTitle:card.contents forState:UIControlStateSelected];
//        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
//        cardButton.selected = card.isFaceUp;
//        cardButton.enabled = !card.isUnplayable;
//        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
//        
//        UIImage *cardback = card.isFaceUp ? nil : cardbackImage;
//        cardButton.imageEdgeInsets = UIEdgeInsetsMake(-60,-55,-60,-55);
//        [cardButton setImage:cardback forState:UIControlStateNormal];
//    }

    [super updateUI];
}

@end
