//
//  ECTProgressView.m
//  Color Countdown
//
//  Created by Byrdann Fox on 7/11/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import "ECTProgressView.h"
#import "ECTPacManLayer.h"

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
    
    return [ECTPacManLayer class];
    
}

- (CGFloat)angle {
    
    ECTPacManLayer *shapeLayer = (ECTPacManLayer *)self.layer;
    return shapeLayer.angle;

}

- (void)setAngle:(CGFloat)angle

{
    
    ECTPacManLayer *shapeLayer = (ECTPacManLayer *)self.layer;
    shapeLayer.angle = angle;
    
    [self setNeedsDisplay];
    
}

@end

