//
//  SetCardView.h
//  Matchismo
//
//  Created by Dominic Chan on 3/3/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger symbol;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger color;

@property (nonatomic) BOOL faceUp;

@end
