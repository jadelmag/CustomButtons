//
//  ProgressBar.m
//  CustomButtons
//
//  Created by Javier Delgado on 08/09/13.
//  Copyright (c) 2013 Javier Delgado. All rights reserved.
//

#import "ProgressBar.h"

@implementation ProgressBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        _name = @"ProgressBar";
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* gradientColor2 = [UIColor colorWithRed: 0 green: 0.001 blue: 0.001 alpha: 1];
    UIColor* gradient2Color = [UIColor colorWithRed: 0.667 green: 0.686 blue: 0.706 alpha: 1];
    UIColor* gradient2Color2 = [UIColor colorWithRed: 0.9 green: 0.911 blue: 0.922 alpha: 1];
    UIColor* color4 = [UIColor colorWithRed: 0.333 green: 0.333 blue: 0.333 alpha: 1];
    UIColor* color5 = [UIColor colorWithRed: 0 green: 0.59 blue: 0.886 alpha: 1];
    
    //// Gradient Declarations
    NSArray* gradient2Colors = [NSArray arrayWithObjects:
                                (id)gradient2Color.CGColor,
                                (id)gradient2Color2.CGColor, nil];
    CGFloat gradient2Locations[] = {0, 1};
    CGGradientRef gradient2 = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradient2Colors, gradient2Locations);
    
    //// Shadow Declarations
    UIColor* shadow = [gradientColor2 colorWithAlphaComponent: 0.5];
    CGSize shadowOffset = CGSizeMake(0.1, 6.1);
    CGFloat shadowBlurRadius = 7;
    UIColor* shadow2 = [gradient2Color2 colorWithAlphaComponent: 0.7];
    CGSize shadow2Offset = CGSizeMake(3.1, 3.1);
    CGFloat shadow2BlurRadius = 5;
    
    //// Image Declarations
    UIImage* image = [UIImage imageNamed:@"pattern"];
    UIColor* imagePattern = [UIColor colorWithPatternImage: image];
    
    //// Frames
    CGRect progressIndicatorFrame = rect; //CGRectMake(70, 125, 282, 42);
    
    //// Subframes
    CGRect progressActiveGroup = CGRectMake(CGRectGetMinX(progressIndicatorFrame) + 17, CGRectGetMinY(progressIndicatorFrame) + 15, CGRectGetWidth(progressIndicatorFrame) - 82, 10);
    CGRect activeProgresFrame = CGRectMake(CGRectGetMinX(progressActiveGroup) + floor(CGRectGetWidth(progressActiveGroup) * 0.00000 + 0.5), CGRectGetMinY(progressActiveGroup) + floor(CGRectGetHeight(progressActiveGroup) * 0.00000) + 0.5, floor(CGRectGetWidth(progressActiveGroup) * 1.00000 + 0.5) - floor(CGRectGetWidth(progressActiveGroup) * 0.00000 + 0.5), floor(CGRectGetHeight(progressActiveGroup) * 0.95000 + 0.5) - floor(CGRectGetHeight(progressActiveGroup) * 0.00000) - 0.5);
    
    
    //// Abstracted Attributes
    NSString* percentageContent = [NSString stringWithFormat:@"%d %%",(int)(self.progress * 100.0)];
    
    
    //// ProgressBar
    {
        //// Border Drawing
        CGRect borderRect = CGRectMake(CGRectGetMinX(progressIndicatorFrame), CGRectGetMinY(progressIndicatorFrame), 282, 41);
        UIBezierPath* borderPath = [UIBezierPath bezierPathWithRoundedRect: borderRect cornerRadius: 20];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [borderPath addClip];
        CGContextDrawLinearGradient(context, gradient2,
                                    CGPointMake(CGRectGetMidX(borderRect), CGRectGetMaxY(borderRect)),
                                    CGPointMake(CGRectGetMidX(borderRect), CGRectGetMinY(borderRect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        
        ////// Border Inner Shadow
        CGRect borderBorderRect = CGRectInset([borderPath bounds], -shadow2BlurRadius, -shadow2BlurRadius);
        borderBorderRect = CGRectOffset(borderBorderRect, -shadow2Offset.width, -shadow2Offset.height);
        borderBorderRect = CGRectInset(CGRectUnion(borderBorderRect, [borderPath bounds]), -1, -1);
        
        UIBezierPath* borderNegativePath = [UIBezierPath bezierPathWithRect: borderBorderRect];
        [borderNegativePath appendPath: borderPath];
        borderNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = shadow2Offset.width + round(borderBorderRect.size.width);
            CGFloat yOffset = shadow2Offset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        shadow2BlurRadius,
                                        shadow2.CGColor);
            
            [borderPath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(borderBorderRect.size.width), 0);
            [borderNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [borderNegativePath fill];
        }
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        
        
        //// ProgressTrack Drawing
        UIBezierPath* progressTrackPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(progressIndicatorFrame) + 17, CGRectGetMinY(progressIndicatorFrame) + 15, 200, 10) cornerRadius: 5];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2.CGColor);
        [gradient2Color setFill];
        [progressTrackPath fill];
        
        ////// ProgressTrack Inner Shadow
        CGRect progressTrackBorderRect = CGRectInset([progressTrackPath bounds], -shadowBlurRadius, -shadowBlurRadius);
        progressTrackBorderRect = CGRectOffset(progressTrackBorderRect, -shadowOffset.width, -shadowOffset.height);
        progressTrackBorderRect = CGRectInset(CGRectUnion(progressTrackBorderRect, [progressTrackPath bounds]), -1, -1);
        
        UIBezierPath* progressTrackNegativePath = [UIBezierPath bezierPathWithRect: progressTrackBorderRect];
        [progressTrackNegativePath appendPath: progressTrackPath];
        progressTrackNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = shadowOffset.width + round(progressTrackBorderRect.size.width);
            CGFloat yOffset = shadowOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        shadowBlurRadius,
                                        shadow.CGColor);
            
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
            //// ProgressTrackActive Drawing
            CGFloat height = 0.0;
            if (self.progress > 0.0)
                height = 7;
            
            CGRect progressTrackActiveRect = CGRectMake(CGRectGetMinX(activeProgresFrame) + 2, CGRectGetMinY(activeProgresFrame) + 1.5, (CGRectGetWidth(activeProgresFrame) - 4) * self.progress, height);
            UIBezierPath* progressTrackActivePath = [UIBezierPath bezierPathWithRoundedRect: progressTrackActiveRect cornerRadius: 3.5];
            CGContextSaveGState(context);
            CGContextSetPatternPhase(context, CGSizeMake(CGRectGetMinX(progressTrackActiveRect), CGRectGetMinY(progressTrackActiveRect) + 10));
            [imagePattern setFill];
            [progressTrackActivePath fill];
            CGContextRestoreGState(context);
            [color5 setStroke];
            progressTrackActivePath.lineWidth = 1;
            [progressTrackActivePath stroke];
        }
        
        
        //// Percentage Drawing
        CGRect percentageRect = CGRectMake(CGRectGetMinX(progressIndicatorFrame) + 217, CGRectGetMinY(progressIndicatorFrame), CGRectGetWidth(progressIndicatorFrame) - 217, 41);
        [color4 setFill];
        [percentageContent drawInRect: CGRectInset(percentageRect, 0, 9) withFont: [UIFont fontWithName: @"Helvetica-Bold" size: 15] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
    }
    
    
    //// Cleanup
    CGGradientRelease(gradient2);
    CGColorSpaceRelease(colorSpace);
}

@end