//
//  CustomButtonController.m
//  CustomButtons
//
//  Created by Javier Delgado on 06/09/13.
//  Copyright (c) 2013 Javier Delgado. All rights reserved.
//

#import "CustomButtonController.h"

@interface CustomButtonController () <WaveButtonDelegate>

//ProgressBar properties
@property (weak, nonatomic) ProgressBar *progressBar;
@property (weak, nonatomic) ProgressBar2 *progressBar2;
@property (weak, nonatomic) ProgressCircle *progressCircle;
@property (weak, nonatomic) ProgressBarRounded *progressBarRounded;
@property (weak, nonatomic) IBOutlet UIButton *startProgressButton;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation CustomButtonController

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initButtonInView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init

- (void)initButtonInView
{
    if ([self.detailItem class] == [WaveButton class])
    {
        WaveButton *objectButton = (WaveButton *)self.detailItem;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(115, 150, 100, 100)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:objectButton.name];
        
        [self.view addSubview:objectButton];
        [self.view addSubview:label];
        
        [self initViewWithName:objectButton.name];
    }
    else if ([self.detailItem class] == [ProgressBar class])
    {
        self.startProgressButton.enabled = YES;
        self.startProgressButton.hidden = NO;
        
        ProgressBar *objectButton = (ProgressBar *)self.detailItem;
        self.progressBar = objectButton;
        self.progressBar.progress = 0.0;
        [self.view addSubview:self.progressBar];
        [self initViewWithName:self.progressBar.name];
    }
    else if ([self.detailItem class] == [ProgressBar2 class])
    {
        self.startProgressButton.enabled = YES;
        self.startProgressButton.hidden = NO;
        
        ProgressBar2 *objectButton = (ProgressBar2 *)self.detailItem;
        self.progressBar2 = objectButton;
        self.progressBar2.progress = 0.0;
        [self.view addSubview:self.progressBar2];
        [self initViewWithName:self.progressBar2.name];
    }
    else if ([self.detailItem class] == [ProgressBarRounded class])
    {
        self.startProgressButton.enabled = YES;
        self.startProgressButton.hidden = NO;
        
        ProgressBarRounded *objectButton = (ProgressBarRounded *)self.detailItem;
        self.progressBarRounded = objectButton;
        self.progressBarRounded.progress = 0.0;
        [self.view addSubview:self.progressBarRounded];
        [self initViewWithName:self.progressBarRounded.name];
    }
    else if ([self.detailItem class] == [ProgressCircle class])
    {
        self.startProgressButton.enabled = YES;
        self.startProgressButton.hidden = NO;
        
        ProgressCircle *objectButton = (ProgressCircle *)self.detailItem;
        self.progressCircle = objectButton;
        self.progressCircle.progress = 0.0;
        [self.view addSubview:self.progressCircle];
        [self initViewWithName:self.progressCircle.name];
    }
}

- (void)initViewWithName:(NSString *)name
{
    self.title = name;
}

#pragma mark - WaveButton Methods

- (void) buttonHit:(UIView *)button
{
    NSLog (@"Button Wave touched: %d", button.tag);
}

#pragma mark - ProgressBar Methods

-(IBAction)startProgressTapped
{
    if ([self.detailItem class] == [ProgressBar class])
        self.progressBar.progress = 0.0;
    else if ([self.detailItem class] == [ProgressBar2 class])
        self.progressBar2.progress = 0.0;
    else if ([self.detailItem class] == [ProgressBarRounded class])
        self.progressBarRounded.progress = 0.0;
    else if ([self.detailItem class] == [ProgressCircle class])
        self.progressCircle.progress = 0.0;
    
    self.startProgressButton.enabled = NO;
    
    self.timer = [NSTimer timerWithTimeInterval:kUpdateInterval
                                         target:self
                                       selector:@selector(updateProgressView)
                                       userInfo:nil
                                        repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [self.timer fire];
}

-(void)updateProgressView;
{
    if ([self.detailItem class] == [ProgressBar class] && self.progressBar.progress < 1.0)
        self.progressBar.progress += (kUpdateInterval / kSecondsForCompleteUpdate);
    else if ([self.detailItem class] == [ProgressBar2 class] && self.progressBar2.progress < 1.0)
        self.progressBar2.progress += (kUpdateInterval / kSecondsForCompleteUpdate);
    else if ([self.detailItem class] == [ProgressBarRounded class] && self.progressBarRounded.progress < 1.0)
        self.progressBarRounded.progress += (kUpdateInterval / kSecondsForCompleteUpdate);
    else if ([self.detailItem class] == [ProgressCircle class] && self.progressCircle.progress < 1.0)
        self.progressCircle.progress += (kUpdateInterval / kSecondsForCompleteUpdate);
    else
    {
        [self.timer invalidate];
        self.startProgressButton.enabled = YES;
        [[[UIAlertView alloc] initWithTitle:@"Progress Completed!!" message:nil delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];
    }
}

@end
