//
//  ViewController.m
//  CustomButtons
//
//  Created by Javier Delgado on 06/09/13.
//  Copyright (c) 2013 Javier Delgado. All rights reserved.
//

#import "ViewController.h"
#import "CustomButtonController.h"

#import "WaveButton.h"
#import "ProgressBar.h"
#import "ProgressBar2.h"
#import "ProgressBarRounded.h"
#import "ProgressCircle.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray *arrayButtons;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.arrayButtons = [[NSArray alloc] initWithObjects:@"Wave Button", @"Progress Bar", @"Progress Bar 2", @"Rounded Progress Bar", @"Progress Circle", nil];
    [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayButtons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.arrayButtons[indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        // Buttons
        WaveButton *waveButton = nil;
        ProgressBar *progressBar = nil;
        ProgressBar2 *progressBar2 = nil;
        ProgressBarRounded *progressBarRounded = nil;
        ProgressCircle *progressCircle = nil;
        
        // Detect kind of button
        if ([self.arrayButtons[indexPath.row] isEqualToString:@"Wave Button"])
        {
            NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"slide-magic" ofType: @"aif"];
            
            waveButton = [[WaveButton alloc]initWithFrame:CGRectMake(110, 80, 100, 100)
                                            internalColor:[UIColor whiteColor]
                                            externalColor:[UIColor whiteColor]
                                              soundFXPath:soundFilePath];
            
            waveButton.delegate = [segue destinationViewController];
            waveButton.alpha = 0.85;
            waveButton.tag = 1;
            
            [[segue destinationViewController] setDetailItem:waveButton];
        }
        else if ([self.arrayButtons[indexPath.row] isEqualToString:@"Progress Bar"])
        {
            progressBar = [[ProgressBar alloc] initWithFrame:CGRectMake(20, 80, 282, 60)];
            [[segue destinationViewController] setDetailItem:progressBar];
        }
        else if ([self.arrayButtons[indexPath.row] isEqualToString:@"Progress Bar 2"])
        {
            progressBar2 = [[ProgressBar2 alloc] initWithFrame:CGRectMake(0, 80, 320, 240)];
            [[segue destinationViewController] setDetailItem:progressBar2];
        }
        else if ([self.arrayButtons[indexPath.row] isEqualToString:@"Rounded Progress Bar"])
        {
            progressBarRounded = [[ProgressBarRounded alloc] initWithFrame:CGRectMake(0, 60, 320, 240)];
            [[segue destinationViewController] setDetailItem:progressBarRounded];
        }
        else if ([self.arrayButtons[indexPath.row] isEqualToString:@"Progress Circle"])
        {
            progressCircle = [[ProgressCircle alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
            [[segue destinationViewController] setDetailItem:progressCircle];
        }
    }
}

@end
