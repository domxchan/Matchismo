//
//  SetCardCollectionViewCell.h
//  Matchismo
//
//  Created by Dominic Chan on 3/3/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCardView.h"

@interface SetCardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet SetCardView *setCardView;
@end
