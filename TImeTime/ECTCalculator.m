//
//  ECTCalculator.m
//  TImeTime
//
//  Created by Byrdann Fox on 6/9/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import "ECTCalculator.h"

@implementation ECTCalculator

{
 
    double total;

}

- (void) clear
{
    total = 0.00;
}
- (double)addToTotal:(double)value
{
    total += value;
    return total;
}
- (double)subtractFromTotal:(double)value
{
    total -= value;
    return total;
}
- (double)multiplyTotal:(double)value
{
    total *= value;
    return total;
}
- (double)divideTotal:(double)value
{
    total /= value;
    return total;
}

@end