//
//  ECTAppDelegate.m
//  TImeTime
//
//  Created by Byrdann Fox on 6/9/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

// does all background processing code go into the delegation files?

/*
 
 // rested resources...
 
 // UIKit Dynamics Catalog...
 
 MENTOR NOTES...
 
 - data network for med records..
 - hardware and data for workouts, etc...
 - clinical data intry and analysis...
 - virtual rehab for xbox...
 - chat room...
 - chats and records...
 - med interaction checks, pills updates...
 - non invasive med. algorithms and analysis...
 - mobile apps for special needs...
 
*/

#import "ECTAppDelegate.h"
// #import "ECTViewController.h"

// SAVE THIS TO THE FILE SYSTEM...


// subtract from afterRemainder var && add to pauseTracker var...

NSDate *thisMagicMoment;
NSTimeInterval timeOfNoMagic;
NSDate *lastMagicMoment;

@implementation ECTAppDelegate

/*-(BOOL) isMultitaskingSupported {
    
    BOOL result = NO;
    
    if ([[UIDevice currentDevice] respondsToSelector: @selector(isMultitaskingSupported)]) {
        result = [[UIDevice currentDevice] isMultitaskingSupported];
    }
    
    NSLog(@"%d", result);
    
    return result;
    
}

-(void) timerMethod:(NSTimer *)paramSender {
    
    NSTimeInterval backgroundTimeRemaining = [[UIApplication sharedApplication] backgroundTimeRemaining];
    if (backgroundTimeRemaining == DBL_MAX) {
        // NSLog(@"Background Time Remaining = Undetermined");
    } else {
        // NSLog(@"Background Time Remaining = %.02f Seconds", backgroundTimeRemaining);
    }
    
}

-(void) endBackgroundTask {
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    __weak ECTAppDelegate *weakSelf = self;
    dispatch_async(mainQueue, ^(void) {
        ECTAppDelegate *strongSelf = weakSelf;
        if (strongSelf != nil) {
            [strongSelf.autoTimer invalidate];
            [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskIdentifier];
            strongSelf.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
        }
    });
    
}*/

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
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application

{

    NSLog(@"APP HAS ENTERED BACKGROUND...");
    
    timeOfNoMagic = 0;
    lastMagicMoment = nil;
    thisMagicMoment = nil;
    
    // if (backgroundCheck >= 2) {
        
    thisMagicMoment = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:thisMagicMoment forKey:@"lastMagicMoment"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // }
        
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    /*if ([self isMultitaskingSupported] == NO) {
        return;
    }
    
    self.autoTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerMethod:) userInfo:nil repeats:YES];
    
    self.backgroundTaskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^(void) {
        
        [self endBackgroundTask];
        
    }];*/
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"APP WILL ENTER FOREGROUND...");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

    /*if (self.backgroundTaskIdentifier != UIBackgroundTaskInvalid) {
        [self endBackgroundTask];
    }*/
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

    NSLog(@"APP DID BECOME ACTIVE...");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // if (backgroundCheck >= 2) {
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSDate *thisMagicMoment = [NSDate date];
    lastMagicMoment =  (NSDate *)[[NSUserDefaults standardUserDefaults] objectForKey:@"lastMagicMoment"];
    
    if (lastMagicMoment == nil) {
    
        NSLog (@"First launch!");
    
    } else {
        
        // int magicalTime = (int) timeOfNoMagic;
        
        timeOfNoMagic = [thisMagicMoment timeIntervalSinceDate:lastMagicMoment];
        NSLog (@"Application was in background for %f...\n", timeOfNoMagic);
        
        backgroudSubtractionTime = timeOfNoMagic;
        NSLog(@"%f\n", backgroudSubtractionTime);
        
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"APP WILL TERMINATE...");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // timeOfNoMagic = 0.0;
    
}

@end
