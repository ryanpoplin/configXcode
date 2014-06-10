//
//  ECTTimerModel.m
//  TImeTime
//
//  Created by Byrdann Fox on 6/10/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import "ECTTimerModel.h"

@implementation ECTTimerModel

-(id)initWithCoffeeName:(NSString *)coffeeName duration:(NSInteger)duration
{
    self = [super init];
    if (self == nil) return nil;
    self.coffeeName = coffeeName;
    self.duration = duration;
    return self;
}

@end
