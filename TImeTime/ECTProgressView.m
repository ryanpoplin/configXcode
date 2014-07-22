

//
//  ECTProgressView.m
//  Color Countdown
//
//  Created by Byrdann Fox on 7/11/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import "ECTProgressView.h"

@implementation ECTProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setClipsToBounds:NO];
        
        [self.layer setShouldRasterize:YES];
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor

{
    [super setBackgroundColor:[UIColor clearColor]];
    
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    [shapeLayer setFillColor:backgroundColor.CGColor];
}

+ (Class)layerClass

{
    return [CAShapeLayer class];
}

- (void)setAngle:(CGFloat)angle

{
    _angle = angle;
    
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect

{
    
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:centerPoint];
    [path addArcWithCenter:centerPoint
                    radius:CGRectGetWidth(self.bounds)/5.0
                startAngle:0.0
                  endAngle:self.angle
                 clockwise:YES];
    
    [path closePath];
    
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    [shapeLayer setPath:path.CGPath];
    
}

@end

