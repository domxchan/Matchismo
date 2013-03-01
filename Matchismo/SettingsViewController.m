//
//  SettingsViewController.m
//  Matchismo
//
//  Created by Dominic Chan on 23/2/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "SettingsViewController.h"
#define ALL_RESULTS_KEY @"GameResult_All"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
- (IBAction)resetScores {
    [[NSUserDefaults standardUserDefaults] setObject:NULL forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
