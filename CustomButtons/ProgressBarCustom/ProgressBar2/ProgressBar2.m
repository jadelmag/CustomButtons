//
//  ProgressBar2.m
//  CustomButtons
//
//  Created by Javier Delgado on 09/09/13.
//  Copyright (c) 2013 Javier Delgado. All rights reserved.
//

#import "ProgressBar2.h"

@implementation ProgressBar2

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _name = @"ProgressBar2";
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
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* shapeColor = [UIColor colorWithRed: 0.161 green: 0.62 blue: 0.808 alpha: 1];
    
    //// Shadow Declarations
    UIColor* backgroundDropShadow = [color colorWithAlphaComponent: 0.74];
    CGSize backgroundDropShadowOffset = CGSizeMake(0.1, 1.1);
    CGFloat backgroundDropShadowBlurRadius = 0;
    UIColor* backgroundShadow = [UIColor blackColor];
    CGSize backgroundShadowOffset = CGSizeMake(0.1, 5.1);
    CGFloat backgroundShadowBlurRadius = 7;
    
    //// Image Declarations
    UIImage* image = [UIImage imageNamed: @"layer2Image"];
    UIColor* imagePattern = [UIColor colorWithPatternImage: image];
    UIImage* image3 = [UIImage imageNamed: @"backgroundImage"];
    UIColor* image3Pattern = [UIColor colorWithPatternImage: image3];
    UIImage* image4 = [UIImage imageNamed: @"pattern2"];
    UIColor* image4Pattern = [UIColor colorWithPatternImage: image4];
    
    //// Frames
    CGRect frame = rect; //CGRectMake(0, 0, 320, 240);
    
    //// Subframes
    CGRect progressActiveGroup = CGRectMake(CGRectGetMinX(frame) + 13, CGRectGetMinY(frame) + 105, CGRectGetWidth(frame) - 26, 17);
    CGRect activeProgressFrame = CGRectMake(CGRectGetMinX(progressActiveGroup) + floor(CGRectGetWidth(progressActiveGroup) * 0.00000 + 0.5), CGRectGetMinY(progressActiveGroup) + floor(CGRectGetHeight(progressActiveGroup) * 0.00000 + 0.5), floor(CGRectGetWidth(progressActiveGroup) * 1.00000 + 0.5) - floor(CGRectGetWidth(progressActiveGroup) * 0.00000 + 0.5), floor(CGRectGetHeight(progressActiveGroup) * 1.00000 + 0.5) - floor(CGRectGetHeight(progressActiveGroup) * 0.00000 + 0.5));
    
    
    //// Abstracted Attributes
    NSString* percentageContent = [NSString stringWithFormat:@"%d %%",(int)(self.progress * 100.0)];
    
    
    //// ProgressBar
    {
        //// Border Drawing
        CGRect borderRect = CGRectMake(CGRectGetMinX(frame) + 5, CGRectGetMinY(frame) + 60, 310, 100);
        UIBezierPath* borderPath = [UIBezierPath bezierPathWithRoundedRect: borderRect cornerRadius: 4];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, backgroundShadowOffset, backgroundShadowBlurRadius, backgroundShadow.CGColor);
        CGContextSaveGState(context);
        CGContextSetPatternPhase(context, CGSizeMake(CGRectGetMinX(borderRect), CGRectGetMinY(borderRect) - 350));
        [imagePattern setFill];
        [borderPath fill];
        CGContextRestoreGState(context);
        CGContextRestoreGState(context);
        
        [[UIColor blackColor] setStroke];
        borderPath.lineWidth = 1;
        [borderPath stroke];
        
        
        //// BackgroundTrack Drawing
        CGRect backgroundTrackRect = CGRectMake(CGRectGetMinX(frame) + 10, CGRectGetMinY(frame) + 102.5, 300, 33);
        UIBezierPath* backgroundTrackPath = [UIBezierPath bezierPathWithRoundedRect: backgroundTrackRect cornerRadius: 4];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, backgroundDropShadowOffset, backgroundDropShadowBlurRadius, backgroundDropShadow.CGColor);
        CGContextSaveGState(context);
        CGContextSetPatternPhase(context, CGSizeMake(CGRectGetMinX(backgroundTrackRect), CGRectGetMinY(backgroundTrackRect) - 1));
        [image3Pattern setFill];
        [backgroundTrackPath fill];
        CGContextRestoreGState(context);
        CGContextRestoreGState(context);
        
        
        
        //// Percentage Drawing
        CGRect percentageRect = CGRectMake(CGRectGetMinX(frame) + 235, CGRectGetMinY(frame) + 120, 40, 15);
        [color setFill];
        [percentageContent drawInRect: percentageRect withFont: [UIFont fontWithName: @"Helvetica" size: 12] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
        
        
        //// ProgressActiveGroup
        {
            //// ProgressTrackActive Drawing
            UIBezierPath* progressTrackActivePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(activeProgressFrame), CGRectGetMinY(activeProgressFrame) + 0.5, CGRectGetWidth(activeProgressFrame) * self.progress, 15) cornerRadius: 4];
            [shapeColor setFill];
            [progressTrackActivePath fill];
            
            
            //// ProgressTrackActiveWithPattern Drawing
            CGRect progressTrackActiveWithPatternRect = CGRectMake(CGRectGetMinX(activeProgressFrame), CGRectGetMinY(activeProgressFrame) + 0.5, CGRectGetWidth(activeProgressFrame) * self.progress, 15);
            UIBezierPath* progressTrackActiveWithPatternPath = [UIBezierPath bezierPathWithRoundedRect: progressTrackActiveWithPatternRect cornerRadius: 4];
            CGContextSaveGState(context);
            CGContextSetPatternPhase(context, CGSizeMake(CGRectGetMinX(progressTrackActiveWithPatternRect), CGRectGetMinY(progressTrackActiveWithPatternRect)));
            [image4Pattern setFill];
            [progressTrackActiveWithPatternPath fill];
            CGContextRestoreGState(context);
        }
    }
}

@end
