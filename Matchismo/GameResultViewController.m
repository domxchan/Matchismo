//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Dominic Chan on 9/2/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "GameResultViewController.h"

@interface GameResultViewController ()

@property (weak, nonatomic) IBOutlet UITextView *display;
@end

@implementation GameResultViewController

- (void)setup
{
    // initialisation can't wait until viewDidLoad
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

@end
