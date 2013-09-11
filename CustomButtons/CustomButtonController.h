//
//  CustomButtonController.h
//  CustomButtons
//
//  Created by Javier Delgado on 06/09/13.
//  Copyright (c) 2013 Javier Delgado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaveButton.h"
#import "ProgressBar.h"
#import "ProgressBar2.h"
#import "ProgressBarRounded.h"
#import "ProgressCircle.h"

#define kSecondsForCompleteUpdate 3.0
#define kUpdateInterval           0.02

@interface CustomButtonController : UIViewController

@property (strong, nonatomic) id detailItem;

@end
