//
//  ECTAppDelegate.h
//  TImeTime
//
//  Created by Byrdann Fox on 6/9/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import <UIKit/UIKit.h>

float backgroudTime;

BOOL bgColorOption;

BOOL timerLabelOption;

int pauseTracker;

int pauseTime;

BOOL logicGate;

int afterRemainder;

NSTimer *timer;

int bgConSum;

BOOL pauseBool;

UILocalNotification *notification;

float angleGR;

int backgroundSpeed;

@interface ECTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) NSTimer *autoTimer;

@end