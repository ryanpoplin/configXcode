//
//  ECTPacManLayer.m
//  Color Countdown
//
//  Created by Byrdann Fox on 7/22/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import "ECTPacManLayer.h"

@implementation ECTPacManLayer

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if([key isEqualToString:@"angle"]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}

- (void)setAngle:(CGFloat)angle {
    
    _angle = angle;
    [self setNeedsDisplay];
    
}

- (void)drawInContext:(CGContextRef)ctx {
    
    
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:centerPoint];
    [path addArcWithCenter:centerPoint
                    radius:CGRectGetWidth(self.bounds)/5.0
                startAngle:0.0
                  endAngle:self.angle
                 clockwise:YES];
    
    [path closePath];
    
    [self setPath:path.CGPath];

    
}

@end
