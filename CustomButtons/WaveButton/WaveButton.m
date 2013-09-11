//
//  WaveButton.m
//  CustomButtons
//
//  Created by Javier Delgado on 06/09/13.
//  Copyright (c) 2013 Javier Delgado. All rights reserved.
//

#import "WaveButton.h"

@interface WaveButton ()
@property (nonatomic, strong) CAShapeLayer *waveCircle;
@property (nonatomic, strong) UIBezierPath *internalCircle;
@property (nonatomic, strong) UIBezierPath *externalCircle;
@end

@implementation WaveButton

#pragma mark - Initializers

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame internalColor:[UIColor blackColor] externalColor:[UIColor blackColor]];
}

- (id)initWithFrame:(CGRect)frame internalColor:(UIColor *)internalColor externalColor:(UIColor *) externalColor
{
    return [self initWithFrame:frame internalColor:internalColor externalColor:externalColor soundFXPath:nil];
}

- (id)initWithFrame:(CGRect)frame internalColor:(UIColor *)internalColor externalColor:(UIColor *) externalColor soundFXPath:(NSString *)path
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.internalColor = internalColor;
        self.externalColor = externalColor;
        self.name = @"Wave Button";
        [self addAudioFX:path];
    }
    return self;
}

#pragma mark - Draw

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    //// Shadow Declarations
    UIColor* shadow = [UIColor blackColor];
    CGSize shadowOffset = CGSizeMake(0.1, 2.1);
    CGFloat shadowBlurRadius = 2.5;
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
    [color setFill];
    
    //// Drawing code
    //// 1
    self.internalCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 15, 15)];
    [self.internalColor setFill];
    [self.internalCircle fill];
    
    //// 2
    self.externalCircle = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 8, 8)];
    [self.externalColor setStroke];
    self.externalCircle.lineWidth = 4.0;
    [self.externalCircle stroke];
    
    //// Finish Shadow
    CGContextRestoreGState(context);
    
    if (!self.waveCircle)[self addWaveLayer];
}

#pragma mark - Wave

- (void) addWaveLayer
{
    self.waveCircle = [CAShapeLayer layer];
    self.waveCircle.frame = self.bounds;
    self.waveCircle.path = self.externalCircle.CGPath;
    self.waveCircle.strokeColor = self.externalColor.CGColor;
    self.waveCircle.lineWidth = 3.f;
    self.waveCircle.fillColor = [UIColor clearColor].CGColor;
    
    [self.layer addSublayer:self.waveCircle];
}

- (void) animateWave
{
    //1
    CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeOutAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    fadeOutAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    
    //2
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = [NSNumber numberWithFloat:1.0f];
    scale.toValue = [NSNumber numberWithFloat:1.6f];
    
    //3
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.animations = [NSArray arrayWithObjects:fadeOutAnimation, scale, nil];
    group.duration = 0.5;
    [self.waveCircle addAnimation:group forKey:@"trans+opacityAnimation"];
    
}

#pragma mark - Audio

- (void) addAudioFX:(NSString *)fxPath
{
    //PATH EXAMPLE: NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"sound" ofType: @"wav"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: fxPath];
    self.player =[[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                                        error: nil];
    [self.player prepareToPlay];
    self.player.volume = 1.0;
}

#pragma mark - Touch Action

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint pointTouched = [touch locationInView:self];
        CGRect touchableArea = CGRectInset(self.bounds, 10, 10);
        
        if (CGRectContainsPoint(touchableArea, pointTouched)) {
            [self animateWave];
            [self.delegate buttonHit:self];
            if (self.player) [self.player play];
        }
    }
}

@end