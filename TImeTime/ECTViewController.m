

//
//  ECTViewController.m
//  TImeTime
//
//  Created by Byrdann Fox on 6/9/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import "ECTViewController.h"
#import "ECTAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ECTViewController ()

{
    
    int userHours;
    int userMinutes;
    int userSeconds;
    int convertedHours;
    int convertedMinutes;
    int convertedSeconds;
    BOOL pauseBool;
    int currentPauseBuild;
    BOOL pausePress;
    int remainder;
    int bgConSum;
    IBOutlet UIButton *startButton;
    NSTimeInterval countDownInterval;
    
}

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic) NSTimeInterval totalTime;
@property (nonatomic) BOOL isRunning;

@end

BOOL timerLabelOption = true;

@implementation ECTViewController

- (void)viewDidLoad

{
    
    [super viewDidLoad];
    
    NSLog(@"%f\n", backgroudTime);
    
    if (self.view.bounds.size.height == 568) {
        //... other setting for iPhone 4 inch
    } else {
        [self.displayLabel setFrame:CGRectMake(20, 360, 280, 23)];
        [self.colorSegment setFrame:CGRectMake(20, 410, 260, 30)];
        //... other setting for iPhone 3.5 inch
    }
    
    [[_startButton layer] setBorderWidth:0.5f];
    [[_startButton layer] setBorderColor:[UIColor grayColor].CGColor];
    [[_pauseButton layer] setBorderWidth:0.5f];
    [[_pauseButton layer] setBorderColor:[UIColor grayColor].CGColor];
    [[_resetButton layer] setBorderWidth:0.5f];
    [[_resetButton layer] setBorderColor:[UIColor grayColor].CGColor];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    self.displayLabel.hidden = NO;
    self.colorSegment.hidden = NO;
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
    
    backgroudTime = 0.0;
    NSLog(@"%f\n", backgroudTime);
    
    self.instructIndex.hidden = YES;
    self.displayLabel.hidden = NO;
    self.colorSegment.hidden = YES;
    self.segment2.hidden = YES;
    self.segment3.hidden = YES;
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
        self.displayLabel.frame = CGRectMake(15, 305, 280, 80);
        //... other setting for iPhone 4 inch
    } else {
        self.displayLabel.frame = CGRectMake(15, 280, 280, 80);
        //... other setting for iPhone 3.5 inch
    }
    
    self.displayLabel.font = [self.displayLabel.font fontWithSize:58];
    
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
    
    NSLog(@"%f\n", backgroudTime);
    [_startButton setEnabled: YES];
    [_pauseButton setEnabled: NO];
    [_autoTimer invalidate];
    _autoTimer = nil;
    pauseBool = true;
    pauseTime = pauseTracker;
    
}

- (IBAction)resetButton:(id)sender {
    
    self.displayLabel.text = @"";
    self.instructIndex.hidden = NO;
    self.colorSegment.hidden = NO;
    self.segment2.hidden = NO;
    self.segment3.hidden = NO;
    pauseBool = false;
    pauseTracker = 0;
    pausePress = true;
    self.isRunning = false;
    [_autoTimer invalidate];
    _autoTimer = nil;
    [UIView beginAnimations:nil context:nil];
    self.resetButton.enabled = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [_startButton setTitle:NSLocalizedString(@"Start", @"Start It...") forState:UIControlStateNormal];
    self.displayLabel.hidden = YES;
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
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:2.0];
        self.view.backgroundColor = [UIColor redColor];
        [UIView commitAnimations];
        [startButton setTitle:NSLocalizedString(@"Start", @"Start It...") forState:UIControlStateNormal];
        [startButton setEnabled: NO];
        [_pauseButton setEnabled: NO];
        [_autoTimer invalidate];
        _autoTimer = nil;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done!" message:@"" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert show];
        AudioServicesPlaySystemSound(1304);
        
    }
    
    if (timerLabelOption == true) {
        
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
    
}

- (void)updateCountDownReverse {
    
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done!" message:@"" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert show];
        AudioServicesPlaySystemSound(1304);
    }
    
    if (timerLabelOption == true) {
        
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

- (IBAction)segment2:(id)sender {
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    if (selectedSegment == 0) {
        bgColorOption = true;
    } else {
        bgColorOption = false;
    }
    
}

- (IBAction)segment3:(id)sender {
 
 UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
 NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
 if (selectedSegment == 0) {
     timerLabelOption = true;
 } else {
     timerLabelOption = false;
 }
 
 }

@end