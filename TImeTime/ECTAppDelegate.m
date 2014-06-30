//
//  ECTAppDelegate.m
//  TImeTime
//
//  Created by Byrdann Fox on 6/9/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import "ECTAppDelegate.h"

@implementation ECTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSLog(@"APP HAS LAUNCHED...");
    
    // Override point for customization after application launch.
    
    return YES;

}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"APP HAS RESIGNED ACTIVE...");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSDate *thisMagicMoment = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:thisMagicMoment forKey:@"lastMagicMoment"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationDidEnterBackground:(UIApplication *)application

{

    NSLog(@"APP HAS ENTERED BACKGROUND...");
    
    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"APP WILL ENTER FOREGROUND...");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

    NSLog(@"APP DID BECOME ACTIVE...");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSDate *thisMagicMoment = [NSDate date];
    NSDate *lastMagicMoment =  (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"lastMagicMoment"];
    
    if (lastMagicMoment==nil) {
    
        NSLog (@"First launch!");
    
    } else {

        NSTimeInterval timeOfNoMagic = [thisMagicMoment timeIntervalSinceDate:lastMagicMoment];
        NSLog (@"Application was in background for %f...", timeOfNoMagic);
        
        /*backgroudSubtractionTime = 0;
        backgroudSubtractionTime = timeOfNoMagic;*/
        
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"APP WILL TERMINATE...");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
