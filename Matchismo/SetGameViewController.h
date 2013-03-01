//
//  SetGameViewController.h
//  Matchismo
//
//  Created by Dominic Chan on 19/2/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "CardGameViewController.h"
#import "SetCard.h"

@interface SetGameViewController : CardGameViewController
@property (nonatomic) NSUInteger playingMode;
@property (strong, nonatomic) NSString *gameName;
- (NSAttributedString *)attrContents: (SetCard *) card;

@end
