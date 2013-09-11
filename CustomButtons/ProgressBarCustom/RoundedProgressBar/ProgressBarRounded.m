//
//  ProgressBarRounded.m
//  CustomButtons
//
//  Created by Javier Delgado on 09/09/13.
//  Copyright (c) 2013 Javier Delgado. All rights reserved.
//

#import "ProgressBarRounded.h"

@implementation ProgressBarRounded

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _name = @"ProgressBarRounded";
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* barColor = [UIColor colorWithRed: 0.212 green: 0.211 blue: 0.211 alpha: 1];
    UIColor* white = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* shapeColor = [UIColor colorWithRed: 0.639 green: 0.745 blue: 0.263 alpha: 0.8];
    
    //// Shadow Declarations
    UIColor* barDropShadowColor = [white colorWithAlphaComponent: 0.1];
    CGSize barDropShadowColorOffset = CGSizeMake(-1.1, 1.1);
    CGFloat barDropShadowColorBlurRadius = 0;
    UIColor* barInnerShadowColor = [[UIColor blackColor] colorWithAlphaComponent: 0.3];
    CGSize barInnerShadowColorOffset = CGSizeMake(0.1, 2.1);
    CGFloat barInnerShadowColorBlurRadius = 2;
    UIColor* shapeDropShadow = [UIColor blackColor];
    CGSize shapeDropShadowOffset = CGSizeMake(0.1, 1.1);
    CGFloat shapeDropShadowBlurRadius = 0;
    UIColor* shadow = [[UIColor blackColor] colorWithAlphaComponent: 0.9];
    CGSize shadowOffset = CGSizeMake(-1.1, 3.1);
    CGFloat shadowBlurRadius = 7;
    
    //// Image Declarations
    UIImage* gradientImage = [UIImage imageNamed: @"gradientImage"];
    UIColor* gradientImagePattern = [UIColor colorWithPatternImage: gradientImage];
    UIImage* image = [UIImage imageNamed: @"shape1Image"];
    UIColor* imagePattern = [UIColor colorWithPatternImage: image];
    UIImage* arrowImage = [UIImage imageNamed: @"layer1Image"];
    UIColor* arrowImagePattern = [UIColor colorWithPatternImage: arrowImage];
    
    //// Frames
    CGRect progressIndicatorFrame = rect; //CGRectMake(0, 0, 320, 240);
    
    //// Subframes
    CGRect progressActiveGroup = CGRectMake(CGRectGetMinX(progressIndicatorFrame) + 62, CGRectGetMinY(progressIndicatorFrame) + 112, CGRectGetWidth(progressIndicatorFrame) - 122, 17);
    CGRect progressActiveFrame = CGRectMake(CGRectGetMinX(progressActiveGroup) + floor(CGRectGetWidth(progressActiveGroup) * 0.00000 + 0.5), CGRectGetMinY(progressActiveGroup) + floor(CGRectGetHeight(progressActiveGroup) * 0.00000 + 0.5), floor(CGRectGetWidth(progressActiveGroup) * 1.00000 + 0.5) - floor(CGRectGetWidth(progressActiveGroup) * 0.00000 + 0.5), floor(CGRectGetHeight(progressActiveGroup) * 1.00000 + 0.5) - floor(CGRectGetHeight(progressActiveGroup) * 0.00000 + 0.5));
    
    
    //// Abstracted Attributes
    NSString* percentageContent = [NSString stringWithFormat:@"%d %%",(int)(self.progress * 100.0)];
    
    
    //// ProgressBar
    {
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        
        
        //// Border Drawing
        CGRect borderRect = CGRectMake(CGRectGetMinX(progressIndicatorFrame) + 10, CGRectGetMinY(progressIndicatorFrame) + 10, 300, 220);
        UIBezierPath* borderPath = [UIBezierPath bezierPathWithRoundedRect: borderRect cornerRadius: 10];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, barDropShadowColorOffset, barDropShadowColorBlurRadius, barDropShadowColor.CGColor);
        CGContextSaveGState(context);
        CGContextSetPatternPhase(context, CGSizeMake(CGRectGetMinX(borderRect), CGRectGetMinY(borderRect)));
        [gradientImagePattern setFill];
        [borderPath fill];
        CGContextRestoreGState(context);
        
        ////// Border Inner Shadow
        CGRect borderBorderRect = CGRectInset([borderPath bounds], -barInnerShadowColorBlurRadius, -barInnerShadowColorBlurRadius);
        borderBorderRect = CGRectOffset(borderBorderRect, -barInnerShadowColorOffset.width, -barInnerShadowColorOffset.height);
        borderBorderRect = CGRectInset(CGRectUnion(borderBorderRect, [borderPath bounds]), -1, -1);
        
        UIBezierPath* borderNegativePath = [UIBezierPath bezierPathWithRect: borderBorderRect];
        [borderNegativePath appendPath: borderPath];
        borderNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = barInnerShadowColorOffset.width + round(borderBorderRect.size.width);
            CGFloat yOffset = barInnerShadowColorOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        barInnerShadowColorBlurRadius,
                                        barInnerShadowColor.CGColor);
            
            [borderPath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(borderBorderRect.size.width), 0);
            [borderNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [borderNegativePath fill];
        }
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        
        
        //// ProgressTrack Drawing
        UIBezierPath* progressTrackPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(progressIndicatorFrame) + 62, CGRectGetMinY(progressIndicatorFrame) + 110, 200, 20) cornerRadius: 10];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, barDropShadowColorOffset, barDropShadowColorBlurRadius, barDropShadowColor.CGColor);
        [barColor setFill];
        [progressTrackPath fill];
        
        ////// ProgressTrack Inner Shadow
        CGRect progressTrackBorderRect = CGRectInset([progressTrackPath bounds], -barInnerShadowColorBlurRadius, -barInnerShadowColorBlurRadius);
        progressTrackBorderRect = CGRectOffset(progressTrackBorderRect, -barInnerShadowColorOffset.width, -barInnerShadowColorOffset.height);
        progressTrackBorderRect = CGRectInset(CGRectUnion(progressTrackBorderRect, [progressTrackPath bounds]), -1, -1);
        
        UIBezierPath* progressTrackNegativePath = [UIBezierPath bezierPathWithRect: progressTrackBorderRect];
        [progressTrackNegativePath appendPath: progressTrackPath];
        progressTrackNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = barInnerShadowColorOffset.width + round(progressTrackBorderRect.size.width);
            CGFloat yOffset = barInnerShadowColorOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        barInnerShadowColorBlurRadius,
                                        barInnerShadowColor.CGColor);
            
            [progressTrackPath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(progressTrackBorderRect.size.width), 0);
            [progressTrackNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [progressTrackNegativePath fill];
        }
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        
        
        //// ProgressActiveGroup
        {
            //// ProgressActiveTrack Drawing
            CGFloat height = 0.0;
            if (self.progress > 0.0)
                height = 16.5;
            
            CGRect progressActiveTrackRect = CGRectMake(CGRectGetMinX(progressActiveFrame) + 1.5, CGRectGetMinY(progressActiveFrame), (CGRectGetWidth(progressActiveFrame) - 1.5) * self.progress, height);
            UIBezierPath* progressActiveTrackPath = [UIBezierPath bezierPathWithRoundedRect: progressActiveTrackRect cornerRadius: 8.25];
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, shapeDropShadowOffset, shapeDropShadowBlurRadius, shapeDropShadow.CGColor);
            CGContextSaveGState(context);
            CGContextSetPatternPhase(context, CGSizeMake(CGRectGetMinX(progressActiveTrackRect), CGRectGetMinY(progressActiveTrackRect) + 22));
            [imagePattern setFill];
            [progressActiveTrackPath fill];
            CGContextRestoreGState(context);
            CGContextRestoreGState(context);
            
            [shapeColor setStroke];
            progressActiveTrackPath.lineWidth = 1;
            [progressActiveTrackPath stroke];
        }
        
        
        //// Arrow Drawing
        CGRect arrowRect = CGRectMake(CGRectGetMinX(progressIndicatorFrame) + 151, CGRectGetMinY(progressIndicatorFrame) + 95, 20, 15);
        UIBezierPath* arrowPath = [UIBezierPath bezierPathWithRect: arrowRect];
        CGContextSaveGState(context);
        CGContextSetPatternPhase(context, CGSizeMake(CGRectGetMinX(arrowRect), CGRectGetMinY(arrowRect) - 1023));
        [arrowImagePattern setFill];
        [arrowPath fill];
        CGContextRestoreGState(context);
        
        
        //// Percentage Drawing
        CGRect percentageRect = CGRectMake(CGRectGetMinX(progressIndicatorFrame) + 141, CGRectGetMinY(progressIndicatorFrame) + 80, CGRectGetWidth(progressIndicatorFrame) - 280, 15);
        [[UIColor blackColor] setFill];
        [percentageContent drawInRect: percentageRect withFont: [UIFont fontWithName: @"HelveticaNeue-Bold" size: [UIFont smallSystemFontSize]] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
        
        
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
    }
}

@end
