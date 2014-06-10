//
//  ECTTimerModel.h
//  TImeTime
//
//  Created by Byrdann Fox on 6/10/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECTTimerModel : NSObject

@property (nonatomic, strong) NSString *coffeeName;
@property (nonatomic, assign) NSInteger duration;
-(id)initWithCoffeeName: (NSString *)coffeeName duration: (NSInteger)duration;

@end
