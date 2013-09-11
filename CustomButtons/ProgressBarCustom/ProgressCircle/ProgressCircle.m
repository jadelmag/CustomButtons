//
//  ProgressCircle.m
//  CustomButtons
//
//  Created by Javier Delgado on 09/09/13.
//  Copyright (c) 2013 Javier Delgado. All rights reserved.
//

#import "ProgressCircle.h"

@implementation ProgressCircle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _name = @"ProgressCircle";
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
    UIColor* gradientColor = [UIColor colorWithRed: 0.263 green: 0.453 blue: 0.533 alpha: 1];
    UIColor* gradientColor2 = [UIColor colorWithRed: 0.316 green: 0.72 blue: 1 alpha: 1];
    UIColor* gradient2Color = [UIColor colorWithRed: 0.777 green: 0.806 blue: 0.847 alpha: 0.8];
    UIColor* gradient2Color2 = [UIColor colorWithRed: 0.777 green: 0.806 blue: 0.83 alpha: 0.8];
    UIColor* color2 = [UIColor colorWithRed: 0.89 green: 0.918 blue: 0.941 alpha: 1];
    UIColor* shadowColor2 = [UIColor colorWithRed: 0.153 green: 0.408 blue: 0.714 alpha: 1];
    UIColor* color3 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* gradientColor3 = [UIColor colorWithRed: 0.263 green: 0.453 blue: 0.533 alpha: 1];
    
    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)gradientColor3.CGColor,
                               (id)gradientColor2.CGColor, nil];
    CGFloat gradientLocations[] = {0.01, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    NSArray* gradient2Colors = [NSArray arrayWithObjects:
                                (id)gradient2Color.CGColor,
                                (id)gradient2Color2.CGColor, nil];
    CGFloat gradient2Locations[] = {0.28, 1};
    CGGradientRef gradient2 = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradient2Colors, gradient2Locations);
    
    //// Shadow Declarations
    UIColor* shadow = [shadowColor2 colorWithAlphaComponent: 0.45];
    CGSize shadowOffset = CGSizeMake(-2.1, 1.1);
    CGFloat shadowBlurRadius = 5;
    UIColor* shadow2 = color3;
    CGSize shadow2Offset = CGSizeMake(0.1, -0.1);
    CGFloat shadow2BlurRadius = 4;
    
    //// Frames
    CGRect circleProgressFrame = CGRectMake(80, 30, 175, 175);
    
    //// Subframes
    CGRect circleActiveFrame = CGRectMake(CGRectGetMinX(circleProgressFrame) + 8, CGRectGetMinY(circleProgressFrame) + 7, 160, 160);
    
    //// CircleProgress
    {
        //// BorderCircle Drawing
        CGRect borderCircleRect = CGRectMake(CGRectGetMinX(circleProgressFrame), CGRectGetMinY(circleProgressFrame), 175, 175);
        UIBezierPath* borderCirclePath = [UIBezierPath bezierPathWithOvalInRect: borderCircleRect];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);
        [borderCirclePath addClip];
        CGContextDrawLinearGradient(context, gradient2,
                                    CGPointMake(CGRectGetMidX(borderCircleRect), CGRectGetMaxY(borderCircleRect)),
                                    CGPointMake(CGRectGetMidX(borderCircleRect), CGRectGetMinY(borderCircleRect)),
                                    0);
        CGContextEndTransparencyLayer(context);
        
        ////// BorderCircle Inner Shadow
        CGRect borderCircleBorderRect = CGRectInset([borderCirclePath bounds], -shadow2BlurRadius, -shadow2BlurRadius);
        borderCircleBorderRect = CGRectOffset(borderCircleBorderRect, -shadow2Offset.width, -shadow2Offset.height);
        borderCircleBorderRect = CGRectInset(CGRectUnion(borderCircleBorderRect, [borderCirclePath bounds]), -1, -1);
        
        UIBezierPath* borderCircleNegativePath = [UIBezierPath bezierPathWithRect: borderCircleBorderRect];
        [borderCircleNegativePath appendPath: borderCirclePath];
        borderCircleNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = shadow2Offset.width + round(borderCircleBorderRect.size.width);
            CGFloat yOffset = shadow2Offset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        shadow2BlurRadius,
                                        shadow2.CGColor);
            
            [borderCirclePath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(borderCircleBorderRect.size.width), 0);
            [borderCircleNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [borderCircleNegativePath fill];
        }
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        [gradient2Color setStroke];
        borderCirclePath.lineWidth = 1;
        [borderCirclePath stroke];
        
        //// BackCircle Drawing
        UIBezierPath* backCirclePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(circleProgressFrame) + 8, CGRectGetMinY(circleProgressFrame) + 7, 160, 160)];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
        [color2 setFill];
        [backCirclePath fill];
        CGContextRestoreGState(context);
        
        //// CircleActiveGroup
        {
            //// CircleActive Drawing
            if (self.progress == 1.0)
            {
                CGRect circleActiveRect = CGRectMake(CGRectGetMinX(circleActiveFrame), CGRectGetMinY(circleActiveFrame), 160, 160);
                UIBezierPath* circleActivePath = [UIBezierPath bezierPathWithOvalInRect: circleActiveRect];
                CGContextSaveGState(context);
                CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
                CGContextBeginTransparencyLayer(context, NULL);
                [circleActivePath addClip];
                CGContextDrawLinearGradient(context, gradient,
                                            CGPointMake(CGRectGetMidX(circleActiveRect), CGRectGetMaxY(circleActiveRect)),
                                            CGPointMake(CGRectGetMidX(circleActiveRect), CGRectGetMinY(circleActiveRect)),
                                            0);
                CGContextEndTransparencyLayer(context);
                CGContextRestoreGState(context);
                
                [gradientColor setStroke];
                circleActivePath.lineWidth = 2;
                [circleActivePath stroke];
            }
            else if (self.progress > 0.0)
            {
                int num = self.progress * 100.0 * 3.6;
                //// CircleActive Drawing
                CGRect circleActiveRect = CGRectMake(CGRectGetMinX(circleActiveFrame), CGRectGetMinY(circleActiveFrame), 160, 160);
                UIBezierPath* circleActivePath = [UIBezierPath bezierPath];
                [circleActivePath addArcWithCenter: CGPointMake(CGRectGetMidX(circleActiveRect), CGRectGetMidY(circleActiveRect)) radius: CGRectGetWidth(circleActiveRect) / 2 startAngle:(270.0 - num) * M_PI/180  endAngle: 270 * M_PI/180 clockwise: YES];
                [circleActivePath addLineToPoint: CGPointMake(CGRectGetMidX(circleActiveRect), CGRectGetMidY(circleActiveRect))];
                [circleActivePath closePath];
                
                CGContextSaveGState(context);
                CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
                CGContextBeginTransparencyLayer(context, NULL);
                [circleActivePath addClip];
                CGContextDrawLinearGradient(context, gradient,
                                            CGPointMake(CGRectGetMidX(circleActiveRect), CGRectGetMaxY(circleActiveRect)),
                                            CGPointMake(CGRectGetMidX(circleActiveRect), CGRectGetMinY(circleActiveRect)),
                                            0);
                CGContextEndTransparencyLayer(context);
                CGContextRestoreGState(context);
                
                [gradientColor setStroke];
                circleActivePath.lineWidth = 2;
                [circleActivePath stroke];
            }
        }
    }
    
    int percentage = self.progress * 100.0;
    //// Abstracted Attributes
    NSString* textContent = [NSString stringWithFormat:@"%d %%",percentage];
    
    //// Text Drawing
    CGRect textRect = CGRectMake(CGRectGetMinX(circleProgressFrame) + 68, CGRectGetMinY(circleProgressFrame) + 79, 40, 15);
    [[UIColor blackColor] setFill];
    [textContent drawInRect: textRect withFont: [UIFont fontWithName: @"Helvetica-Bold" size: 12] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGGradientRelease(gradient2);
    CGColorSpaceRelease(colorSpace);
}

@end
