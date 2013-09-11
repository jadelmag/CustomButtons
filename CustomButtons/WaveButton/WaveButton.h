//
//  WaveButton.h
//  CustomButtons
//
//  Created by Javier Delgado on 06/09/13.
//  Copyright (c) 2013 Javier Delgado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@class WaveButton;

@protocol WaveButtonDelegate
- (void)buttonHit:(WaveButton *)button;
@end

@interface WaveButton : UIView

@property (nonatomic, weak) id  delegate;

@property (nonatomic, assign) NSString *name;
@property (nonatomic, strong) UIColor *internalColor;
@property (nonatomic, strong) UIColor *externalColor;
@property (nonatomic, strong) AVAudioPlayer *player;

- (id)initWithFrame:(CGRect)frame internalColor:(UIColor *)internalColor externalColor:(UIColor *) externalColor;
- (id)initWithFrame:(CGRect)frame internalColor:(UIColor *)internalColor externalColor:(UIColor *) externalColor soundFXPath:(NSString *)path;

- (void) animateWave;
- (void) addAudioFX:(NSString *)fxPath;

@end