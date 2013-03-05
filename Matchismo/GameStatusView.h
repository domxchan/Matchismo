//
//  GameStatusView.h
//  Matchismo
//
//  Created by Dominic Chan on 5/3/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"
#import "SetCardView.h"
#import "Card.h"

@interface GameStatusView : UIView
@property (strong, nonatomic) NSArray *cards;  // of cards
@property (strong, nonatomic) NSAttributedString *prefix;
@property (strong, nonatomic) NSAttributedString *postfix;

@end
