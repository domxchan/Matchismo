//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Dominic Chan on 9/2/13.
//  Copyright (c) 2013 Dominic Chan. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;
@property (nonatomic) BOOL dateAsc;
@property (nonatomic) BOOL scoreAsc;
@property (nonatomic) BOOL durationAsc;

@end


@implementation GameResultViewController
- (IBAction)sortByDate {
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:self.dateAsc selector:@selector(compareByDate:)];
    [self updateUI:sortDescriptor];
    self.dateAsc = !self.dateAsc;
}

- (IBAction)sortByScore {
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:self.scoreAsc selector:@selector(compareByScore:)];
    [self updateUI:sortDescriptor];
    self.scoreAsc = !self.scoreAsc;
}
- (IBAction)sortByDuration {
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:self.durationAsc selector:@selector(compareByDuration:)];
    [self updateUI:sortDescriptor];
    self.durationAsc = !self.durationAsc;
}
     
- (void)updateUI: (NSSortDescriptor *) sortDescriptor
{
    NSString *displayText = @"";
    NSArray* sortedArray = [[GameResult allGameResults] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterLongStyle;

    for (GameResult *result in sortedArray){
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0gs)\n", result.score, [formatter stringFromDate:result.end], round(result.duration)];
    }
    self.display.text = displayText;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self sortByDate];
}

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
