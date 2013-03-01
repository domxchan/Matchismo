//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Dominic Chan on 30/1/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
- (void) updateUI;
@end
