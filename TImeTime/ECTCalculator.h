//
//  ECTCalculator.h
//  TImeTime
//
//  Created by Byrdann Fox on 6/9/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import <Foundation/Foundation.h>

// Public as in other classes can gain access to the props. and meths. in here...

@interface ECTCalculator : NSObject

// Must declare our methods here...

// Let's declare some methods...

// Clear the calculators total...
- (void) clear;

// Add to total...
- (double) addToTotal:(double)value;
// Subtract from total...
- (double) subtractFromTotal:(double)value;
// Multiply total...
- (double) multiplyTotal:(double)value;
// Divide total...
- (double) divideTotal:(double)value;

@end