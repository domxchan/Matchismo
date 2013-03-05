//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Dominic Chan on 30/1/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *playMode;
//@property (weak, nonatomic) IBOutlet UISlider *histSlider;
@property (strong, nonatomic) NSMutableArray *descHistory;
@property (strong, nonatomic) GameResult *gameResult;
@property (strong, nonatomic) Deck *deck;
@property (nonatomic) NSUInteger playingMode;
@property (strong, nonatomic) NSString *gameName;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (strong, nonatomic) IBOutlet UIView *mainView;

@end

@implementation CardGameViewController
- (IBAction)addCards {
    [self.game addCards];
    [self.cardCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.game.numCardsInPlay-1 inSection:0];
    [self.cardCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}

- (NSUInteger)numberOfSectionsInCollections: (UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.game.numCardsInPlay;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UICollectionViewCell alloc] init];// abstract
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animated:(BOOL)animated
{
    // abstract
}

- (GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

- (NSMutableArray *)descHistory
{
    if (!_descHistory) _descHistory = [[NSMutableArray alloc] init];
    return _descHistory;
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount usingDeck:[self createDeck] playingMode: self.playingMode];
        _game.gameName = self.gameName;
        self.flipCount = nil;
        self.gameResult = nil;
        self.descHistory = nil;
    }
    return _game;
}

- (Deck *) createDeck { return nil; } // abstract

- (NSAttributedString *)attrContents: (Card *) card {
    return [[NSAttributedString alloc] initWithString:[card description]];
}

- (void)updateUI
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card animated:YES];
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

    [self updateDesc];
}

- (NSMutableAttributedString *) attributedCardsDesc: (NSArray *) cards {
    
    NSMutableAttributedString *attrCardsDesc = [[NSMutableAttributedString alloc] init];
    NSMutableArray *temp_cards = [cards mutableCopy];
    
    while ([temp_cards count] > 2) {
        [attrCardsDesc appendAttributedString:[self attrContents:temp_cards[0]]];
        [attrCardsDesc appendAttributedString:[[NSAttributedString alloc] initWithString:@", "]];
        [temp_cards removeObjectAtIndex:0];
    }
    
    if ([temp_cards count] == 2) {
        [attrCardsDesc appendAttributedString:[self attrContents:temp_cards[0]]];
        [attrCardsDesc appendAttributedString:[[NSAttributedString alloc] initWithString:@" and "]];
        [temp_cards removeObjectAtIndex:0];
    }
    
    if ([temp_cards count] == 1) {
        [attrCardsDesc appendAttributedString:[self attrContents:temp_cards[0]]];
    }
    
    return attrCardsDesc;
}

- (void) updateDesc
{
    NSAttributedString *cardsDesc = [self attributedCardsDesc: self.game.flippedCards];
    
    NSMutableAttributedString *descText = nil;
    
    if (self.game.flipState == 2) {
        descText = [[NSMutableAttributedString alloc] initWithString:@"Flipped up "];
        [descText appendAttributedString:cardsDesc];
    } else if (self.game.flipState == 1) {
        descText = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
        [descText appendAttributedString:cardsDesc];
        [descText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat: @" for %d points", self.game.scoreChange]]];
    } else if (self.game.flipState == -1) {
        descText = [cardsDesc mutableCopy];
        [descText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat: @" don't match! %d points penalty!", self.game.scoreChange]]];
    }
    self.descLabel.attributedText = descText;
    

}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
//    [UIView beginAnimations:@"flipCard" context:nil];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:sender cache:YES];
//    [UIView setAnimationDuration:0.4];
//    [UIView commitAnimations];

    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
//        if (!sender.selected) self.flipCount++;
        self.flipCount++;
        self.gameResult.score = self.game.score;
        self.gameResult.gameName = self.gameName;

        if ([self.game.cardsIndexesToBeDeleted count] > 0 &&
            self.gameWillRemoveMatchedCards) {
            [self.game deleteCards];
            [self removeCells];
        }
        [self updateUI];
    }
}

- (void)removeCells
{
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    [self.game.cardsIndexesToBeDeleted enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx
                                                     inSection:0];
        [indexPaths addObject:indexPath];
    }];
    [self.cardCollectionView deleteItemsAtIndexPaths:indexPaths];
    [self.game cleanUpCardIndexesToBeDeleted];
}

- (IBAction)deal:(UIButton *)sender {
    self.game = nil;
    [self updateUI];
}
@end
