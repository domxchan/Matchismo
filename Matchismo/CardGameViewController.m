//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Dominic Chan on 30/1/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *playMode;
//@property (weak, nonatomic) IBOutlet UISlider *histSlider;
@property (strong, nonatomic) NSMutableArray *descHistory;
@property (strong, nonatomic) GameResult *gameResult;
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

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init] playingMode:0];
        self.flipCount = nil;
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

- (void)updateUI
{
    
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
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

    NSString *cardsDesc = [NSString stringWithFormat:@"%@", [self.game.flippedCards componentsJoinedByString:@", "]];
    NSRange lastComma = [cardsDesc rangeOfString:@"," options:NSBackwardsSearch];
    if(lastComma.location != NSNotFound) {
        cardsDesc = [cardsDesc stringByReplacingCharactersInRange:lastComma withString: @" and"];
    }
    
    NSString *descText = nil;
    
    if (self.game.flipState == 2) {
        descText = [NSString stringWithFormat:@"Flipped up %@", cardsDesc];
    } else if (self.game.flipState == 1) {
        descText = [NSString stringWithFormat:@"Matched %@ for %d points", cardsDesc, self.game.scoreChange];
    } else if (self.game.flipState == -1) {
        descText = [NSString stringWithFormat:@"%@ don't match! %d points penalty!", cardsDesc, self.game.scoreChange];
    }
    self.descLabel.text = descText;
    
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
    self.flipCount++;
//    self.playMode.enabled = NO;
    [self updateUI];
    self.gameResult.score = self.game.score;
}

- (IBAction)deal:(id)sender {
    self.game = nil;
    self.gameResult = nil;
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
