//
//  ECTAppDelegate.m
//  TImeTime
//
//  Created by Byrdann Fox on 6/9/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import "ECTAppDelegate.h"

NSDate *thisMagicMoment;
NSTimeInterval timeOfNoMagic;
NSDate *lastMagicMoment;

@implementation ECTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Override point for customization after application launch.
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
    logicGate = false;
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    logicGate = true;
    
    if (afterRemainder && pauseTracker != 0 && logicGate == true) {
        
        thisMagicMoment = [NSDate date];
        
        [[NSUserDefaults standardUserDefaults] setObject:thisMagicMoment forKey:@"lastMagicMoment"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    if (afterRemainder && pauseTracker != 0 && logicGate == true) {
        
        NSDate *thisMagicMoment = [NSDate date];
        
        lastMagicMoment = (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"lastMagicMoment"];
        
        timeOfNoMagic = [thisMagicMoment timeIntervalSinceDate:lastMagicMoment];
        
    }
    
    if (lastMagicMoment == nil) {

        // do nothing...
        
    } else {
        
        if (afterRemainder && pauseTracker > 0 && logicGate == true) {
            
            backgroudTime = (int)timeOfNoMagic;
            
        } else {
            
            backgroudTime = 0;
            
        }
        
        if (pauseBool == false && logicGate == true) {
            
            if (afterRemainder && pauseTracker != 0) {
                
                afterRemainder -= backgroudTime - 1;
                
                pauseTracker += backgroudTime - 1;
                                                
                logicGate = false;
                
            }
            
            if (afterRemainder <= 1 && logicGate == false) {
                
                afterRemainder = 1;
                
            }
            
        }
        
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}

@end