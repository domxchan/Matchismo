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

@interface CardGameViewController ()
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

@end

@implementation CardGameViewController

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

- (Deck *) deck {
    return _deck? _deck: [[Deck alloc] init];
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:self.deck playingMode: self.playingMode];
        _game.gameName = self.gameName;
        self.flipCount = nil;
        self.gameResult = nil;
        self.descHistory = nil;
//        self.histSlider.maximumValue = 0;
    }
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (NSAttributedString *)attrContents: (Card *) card {
    return [[NSAttributedString alloc] initWithString:[card description]];
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

- (void)updateUI
{
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

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
    
//    if (descText != NULL) {
//        [self.descHistory addObject:descText];
//        int n = [self.descHistory count] - 1;
//        self.histSlider.maximumValue = n;
//        self.histSlider.value = n;
//        self.descLabel.alpha = (self.histSlider.value < self.histSlider.maximumValue ? 0.3 : 1.0);
//    }
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [UIView beginAnimations:@"flipCard" context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:sender cache:YES];
    [UIView setAnimationDuration:0.4];
    [UIView commitAnimations];
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    if (!sender.selected) self.flipCount++;
//    self.playMode.enabled = NO;
    [self updateUI];
    self.gameResult.score = self.game.score;
    self.gameResult.gameName = self.gameName;
}

- (IBAction)deal:(UIButton *)sender {
    self.game = nil;
//    self.playMode.enabled = YES;
    [self updateUI];
}

//- (IBAction)selectMode:(UISegmentedControl *)sender {
//    self.game = nil;
//    self.playMode.enabled = YES;
//    [self updateUI];
//}
//
//- (IBAction)slideHistory:(UISlider *)sender {
//    if ([self.descHistory count] != 0) {
//        self.descLabel.text = [NSString stringWithFormat:@"%@", self.descHistory[(int) sender.value]];
//        self.descLabel.alpha = (self.histSlider.value < self.histSlider.maximumValue ? 0.3 : 1.0);
//    }
//}
@end
