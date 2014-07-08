

//
//  ECTViewController.m
//  TImeTime
//
//  Created by Byrdann Fox on 6/9/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

// IMPORTED DEPENDENCIES...

#import "ECTViewController.h"
#import "ECTAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

/* MOVE THE DELEGATE CODE INTO HERE AND TRY OUT EVENT LISTENERS... */

// ECTViewController Class...
@interface ECTViewController ()

{
    // values for hours, minutes, and seconds...
    int userHours;
    
    int userMinutes;
    
    int userSeconds;
    
    // converted values for hours, minutes, and seconds for the label object...
    int convertedHours;
    
    int convertedMinutes;
    
    int convertedSeconds;
    
    // was the pause button pressed?
    BOOL pauseBool;
    
    //
    int currentPauseBuild;
    
    //
    BOOL pausePress;
    
    // incremented value for subtracting from the original countdown value...
    int pauseTracker;
    
    int pauseTime;
    
    // the decremented countdown value...
    int afterRemainder;
   
    int remainder;
    
    // the original countdown value...
    int bgConSum;
    
    BOOL bgColorOption;
    
    IBOutlet UIButton *startButton;
    
    // NSTimer *autoTimer;
    
    NSTimeInterval countDownInterval;
        
}

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic) NSTimeInterval totalTime;
@property (nonatomic) BOOL isRunning;
// @property (nonatomic, strong) void (^updateBlock)();

@end

@implementation ECTViewController


/*- (void)dealloc

{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];

}*/

/*- (void)scheduleBackgroundNotificationIfNeeded

{
    
        NSTimeInterval remainingTime = afterRemainder;
        NSDate *endingTime = [[NSDate date] dateByAddingTimeInterval:remainingTime];
    
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        [localNotification setFireDate:endingTime];
        [localNotification setAlertBody:@"Color Countdown Finished!"];
    
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}*/

UILocalNotification *futureAlert;

-(BOOL) isMultitaskingSupported {
    
    BOOL result = NO;
   
    if ([[UIDevice currentDevice] respondsToSelector: @selector(isMultitaskingSupported)]) {
        result = [[UIDevice currentDevice] isMultitaskingSupported];
    }
    
    NSLog(@"%hhd", result);
 
    return result;
    
}

-(void) timerMethod:(NSTimer *)paramSender {
    
    NSTimeInterval backgroundTimeRemaining = [[UIApplication sharedApplication] backgroundTimeRemaining];
    
    if (backgroundTimeRemaining == DBL_MAX) {
        NSLog(@"Background Time Remaining = Undetermined");
    } else {
        NSLog(@"Background Time Remaining = %.02f Seconds", backgroundTimeRemaining);
    }
    
}

- (void)viewDidLoad

{
    
    [super viewDidLoad];
    
    self.displayLabel.hidden = YES;
    
    self.colorSegment.hidden = YES;
    
    [self isMultitaskingSupported];
    
    if (self.view.bounds.size.height == 568) {
        //... other setting for iPhone 4 inch
    } else {
        [self.displayLabel setFrame:CGRectMake(20, 360, 280, 23)];
        [self.colorSegment setFrame:CGRectMake(20, 410, 260, 30)];
        //... other setting for iPhone 3.5 inch
    }
    
    futureAlert = [[UILocalNotification alloc] init];
    
    [futureAlert setAlertBody:@"Color Countdown: Countdown has finished!"];
    
    // [futureAlert setSoundName:<#(NSString *)#>];
    
    futureAlert.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
    
    futureAlert.timeZone = [NSTimeZone defaultTimeZone];
    
    [[UIApplication sharedApplication] scheduleLocalNotification: futureAlert];
    
    /*[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scheduleBackgroundNotificationIfNeeded)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];*/
    
    [[_startButton layer] setBorderWidth:0.5f];
    [[_startButton layer] setBorderColor:[UIColor grayColor].CGColor];
    
    [[_pauseButton layer] setBorderWidth:0.5f];
    [[_pauseButton layer] setBorderColor:[UIColor grayColor].CGColor];
    
    [[_resetButton layer] setBorderWidth:0.5f];
    [[_resetButton layer] setBorderColor:[UIColor grayColor].CGColor];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    self.resetButton.enabled = NO;
    
    self.pauseButton.enabled = NO;
    
    self.displayLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:24];

    self.hourLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:24];

    self.minuteLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:24];

    self.secondLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:24];
    
    pausePress = true;

    self.isRunning = false;
    
    bgColorOption = true;
    
    pauseTracker = 0;
    
}

- (void)didReceiveMemoryWarning

{
    
    [super didReceiveMemoryWarning];
    
}

- (IBAction)startButton:(id)sender {
    
    self.displayLabel.hidden = NO;
    
    self.colorSegment.hidden = YES;
    
    self.resetButton.enabled = YES;
    
    self.hourLabel.hidden = YES;
    
    self.minuteLabel.hidden = YES;
    
    self.secondLabel.hidden = YES;
    
    self.hourSlider.hidden = YES;
    
    self.minuteSlider.hidden = YES;
    
    self.secondsSlider.hidden = YES;
    
    [_startButton setEnabled: NO];
    
    [_pauseButton setEnabled: YES];
    
    self.startTime = [[NSDate alloc] init];
    
    self.startTime = [NSDate date];
    
    if (self.view.bounds.size.height == 568) {
        self.displayLabel.frame = CGRectMake(20, 305, 280, 80);
        //... other setting for iPhone 4 inch
    } else {
        self.displayLabel.frame = CGRectMake(20, 280, 280, 80);
        //... other setting for iPhone 3.5 inch
    }

    self.displayLabel.font = [self.displayLabel.font fontWithSize:80];
    
    if (userHours == 0) {
        
        convertedHours = 0;
        
    } else {
    
        convertedHours = userHours * (60 * 60);
        
    }
    
    if (userMinutes == 0) {
        
        convertedMinutes = 0;
        
    } else {
        
        convertedMinutes = userMinutes * 60;
        
    }
    
    if (userSeconds == 0) {
        
        convertedSeconds = 0;
        
    } else {
        
        convertedSeconds = userSeconds;
        
    }
    
    if (pauseBool) {
        
        countDownInterval = 1 + convertedHours + convertedMinutes;
        
        remainder = countDownInterval;
        
        afterRemainder = 1 + convertedSeconds + remainder - remainder % 60;
        
        afterRemainder -= pauseTracker;
        
    } else {
        
        countDownInterval = 1 + convertedHours + convertedMinutes;
        
        remainder = countDownInterval;
        
        afterRemainder = 1 + convertedSeconds + remainder - remainder % 60;
        
    }
    
    if (pauseBool != true) {
    
        bgConSum = afterRemainder;
        
    }
    
    if (bgColorOption) {
        
        _autoTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
        
    } else {
        
        _autoTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDownReverse) userInfo:nil repeats:YES];
        
    }
    
    self.isRunning = !self.isRunning;
    
    if (self.isRunning == false) {
        
        [_startButton setTitle:NSLocalizedString(@"Start", @"Start It...") forState:UIControlStateNormal];
        
    } else if (pausePress && bgColorOption == true && pauseBool != true) {
        
        [self.view setBackgroundColor:[UIColor greenColor]];
        
    } else if (pausePress && bgColorOption == false && pauseBool != true) {
        
        [self.view setBackgroundColor:[UIColor redColor]];
        
    }
    
}

- (IBAction)pauseMeth:(id)sender {
    
    [_startButton setEnabled: YES];
    
    [_pauseButton setEnabled: NO];
    
    [_autoTimer invalidate];
    
    _autoTimer = nil;
    
    pauseBool = true;
    
    pauseTime = pauseTracker;
    
}

- (IBAction)resetButton:(id)sender {
    
    pauseBool = false;
    
    // self.colorSegment.hidden = NO;
    
    pauseTracker = 0;
    
    pausePress = true;
    
    self.isRunning = false;
    
    [_autoTimer invalidate];
    
    _autoTimer = nil;
    
    [UIView beginAnimations:nil context:nil];
    
    self.colorSegment.hidden = YES;
    
    self.resetButton.enabled = NO;

    self.view.backgroundColor = [UIColor whiteColor];
    
    [_startButton setTitle:NSLocalizedString(@"Start", @"Start It...") forState:UIControlStateNormal];
    
    self.displayLabel.hidden = YES;
    
    self.displayLabel.text = @"";
    
    self.hourLabel.hidden = NO;
    
    self.minuteLabel.hidden = NO;
    
    self.secondLabel.hidden = NO;
    
    self.hourSlider.hidden = NO;
    
    self.minuteSlider.hidden = NO;
    
    self.secondsSlider.hidden = NO;
    
    [_startButton setEnabled: YES];
    
    [_pauseButton setEnabled: NO];
    
    if (self.view.bounds.size.height == 568) {
        self.displayLabel.frame = CGRectMake(20, 371, 280, 35);
        //... other setting for iPhone 4 inch
    } else {
        self.displayLabel.frame = CGRectMake(20, 350, 280, 35);
        //... other setting for iPhone 3.5 inch
    }
    
    self.displayLabel.font = [self.displayLabel.font fontWithSize:24];
    
}

- (void)updateCountDown {
    
    [self updateCountDown2];
    
    NSLog(@"%d", afterRemainder);
    
    pauseTracker++;
    
    NSLog(@"%d", pauseTracker);
    
    afterRemainder--;
    
    if (afterRemainder > bgConSum * 0.80) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor colorWithRed:173.0/255.0 green:255.0/255.0 blue:47.0/255.0 alpha:1];
        
        [UIView commitAnimations];
        
        NSLog(@"%d and %d", afterRemainder, bgConSum);
        
    } else if (afterRemainder < bgConSum * 0.80 && afterRemainder > bgConSum * 0.60) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor yellowColor];
        
        [UIView commitAnimations];
    
    } else if (afterRemainder < bgConSum * 0.60 && afterRemainder > bgConSum * 0.40) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0/255.0 alpha:1];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder < bgConSum * 0.40 && afterRemainder > bgConSum * 0.20) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor orangeColor];
        
        [UIView commitAnimations];
    
    } else if (afterRemainder < bgConSum * 0.20 && afterRemainder > 0) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:69.0/255.0 blue:66.0/255.0 alpha:1];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder == 0) {
        
        // [[UIApplication sharedApplication] endBackgroundTask:_backgroundTaskIdentifier];
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:2.0];
        
        self.view.backgroundColor = [UIColor redColor];
        
        [UIView commitAnimations];
        
        [startButton setTitle:NSLocalizedString(@"Start", @"Start It...") forState:UIControlStateNormal];
        
        [startButton setEnabled: NO];
        
        [_pauseButton setEnabled: NO];
        
        [_autoTimer invalidate];
        
        _autoTimer = nil;
        
        // ALERT MODAL...
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done!" message:@"" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        
        [alert show];
        
        AudioServicesPlaySystemSound(1304);
        
        // ALERT BACKGROUND PUSH NOTIFICATION...
        [[UIApplication sharedApplication] scheduleLocalNotification: futureAlert];
        
    }
    
    int hours = (int)(afterRemainder / ( 60 * 60 ));
    
    int mins = (int)(((int)afterRemainder / 60 ) - ( hours * 60 ));
    
    int secs = (int)(((int)afterRemainder - ( 60 * mins ) - ( 60 * hours * 60 )));
    
    if (hours != 0) {
    
        NSString *displayText = [[NSString alloc] initWithFormat:@"%2u : %02u : %02u ", hours, mins, secs];
        
        self.displayLabel.text = displayText;
    
    } else if (hours == 0 && mins != 0) {
    
        NSString *displayText = [[NSString alloc] initWithFormat:@"%2u : %02u ", mins, secs];
        
        self.displayLabel.text = displayText;
    
    } else if (hours == 0 && mins == 0 && secs >= 0) {
    
        NSString *displayText = [[NSString alloc] initWithFormat:@"%2u ", secs];
        
        self.displayLabel.text = displayText;

    }

}

- (void)updateCountDownReverse {
    
    [self updateCountDown2];
    
    NSLog(@"%d", afterRemainder);
    
    pauseTracker++;
    
    NSLog(@"%d", pauseTracker);
    
    afterRemainder--;
    
    if (afterRemainder > bgConSum * 0.80) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:69.0/255.0 blue:66.0/255.0 alpha:1];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder < bgConSum * 0.80 && afterRemainder > bgConSum * 0.60) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor orangeColor];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder < bgConSum * 0.60 && afterRemainder > bgConSum * 0.40) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];

        self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0/255.0 alpha:1];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder < bgConSum * 0.40 && afterRemainder > bgConSum * 0.20) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor yellowColor];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder < bgConSum * 0.20 && afterRemainder > 0) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor colorWithRed:173.0/255.0 green:255.0/255.0 blue:47.0/255.0 alpha:1];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder == 0) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:2.0];
        
        self.view.backgroundColor = [UIColor greenColor];
        
        [UIView commitAnimations];
        
        [startButton setTitle:NSLocalizedString(@"Start", @"Start It...") forState:UIControlStateNormal];
        
        [startButton setEnabled: NO];
        
        [_pauseButton setEnabled: NO];
        
        [_autoTimer invalidate];
        
        _autoTimer = nil;
        
        // ALERT MODAL...
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done!" message:@"" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        
        [alert show];
        
        AudioServicesPlaySystemSound(1304);
        
        // ALERT BACKGROUND PUSH NOTIFICATION...
        [[UIApplication sharedApplication] scheduleLocalNotification: futureAlert];
        
    }
    
    int hours = (int)(afterRemainder / ( 60 * 60 ));
    
    int mins = (int)(((int)afterRemainder / 60 ) - ( hours * 60 ));
    
    int secs = (int)(((int)afterRemainder - ( 60 * mins ) - ( 60 * hours * 60)));
    
    if (hours != 0) {
        
        NSString *displayText = [[NSString alloc] initWithFormat:@"%2u : %02u : %02u ", hours, mins, secs];
        
        self.displayLabel.text = displayText;
        
    } else if (hours == 0 && mins != 0) {
        
        NSString *displayText = [[NSString alloc] initWithFormat:@"%2u : %02u ", mins, secs];
        
        self.displayLabel.text = displayText;
        
    } else if (hours == 0 && mins == 0 && secs >= 0) {
        
        NSString *displayText = [[NSString alloc] initWithFormat:@"%2u ", secs];
        
        self.displayLabel.text = displayText;
        
    }
    
}

- (void)updateCountDown2

{

    /*NSTimeInterval elapsedTime = -[self.startTime timeIntervalSinceNow];
    
    CGFloat elapsedPercent = elapsedTime / self.totalTime;
    
    NSLog(@"Elapsed Percent: %f", elapsedPercent);*/

}

- (IBAction)hoursMoved:(id)sender {
    
    UISlider *hourSlider = (UISlider *)sender;
    
    NSString *sliderValueAsStringHour = [NSString stringWithFormat:@"%d Hour", (int)[hourSlider value]];
    
    NSString *sliderValueAsStringHours = [NSString stringWithFormat:@"%d Hours", (int)[hourSlider value]];
    
    if ((int)[hourSlider value] == 1) {
        self.hourLabel.text = sliderValueAsStringHour;
    } else {
        self.hourLabel.text = sliderValueAsStringHours;
    }
    
    userHours = (int)[hourSlider value];
    
}

- (IBAction)minutesMoved:(id)sender {

    UISlider *minuteSlider = (UISlider *)sender;
    
    NSString *sliderValueAsStringMinute = [NSString stringWithFormat:@"%d Minute", (int)[minuteSlider value]];
    
    NSString *sliderValueAsStringMinutes = [NSString stringWithFormat:@"%d Minutes", (int)[minuteSlider value]];
    
    if ((int)[minuteSlider value] == 1) {
        self.minuteLabel.text = sliderValueAsStringMinute;
    } else {
        self.minuteLabel.text = sliderValueAsStringMinutes;
    }
    
    userMinutes = (int)[minuteSlider value];

}

- (IBAction)secondsMoved:(id)sender {

    UISlider *secondSlider = (UISlider *)sender;
    
    NSString *sliderValueAsStringSecond = [NSString stringWithFormat:@"%d Second", (int)[secondSlider value]];

    NSString *sliderValueAsStringSeconds = [NSString stringWithFormat:@"%d Seconds", (int)[secondSlider value]];
    
    if ((int)[secondSlider value] == 1) {
        self.secondLabel.text = sliderValueAsStringSecond;
    } else {
        self.secondLabel.text = sliderValueAsStringSeconds;
    }
    
    userSeconds = (int)[secondSlider value];
    
}

- (IBAction)segmentSwitch:(id)sender {
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        
        bgColorOption = true;
        
    } else {
    
        bgColorOption = false;
    
    }

}

@end

