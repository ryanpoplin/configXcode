//
//  ECTViewController.m
//  TImeTime
//
//  Created by Byrdann Fox on 6/9/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import "ECTViewController.h"
#import "ECTProgressView.h"
#import "ECTAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ECTViewController () {
    
    float percentageDone;
    int userHours;
    int userMinutes;
    int userSeconds;
    int convertedHours;
    int convertedMinutes;
    int convertedSeconds;
    int remainder;
    NSTimeInterval countDownInterval;
    ECTProgressView *pacManView;
    
}

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic) NSTimeInterval totalTime;
@property (nonatomic) BOOL isRunning;

@end

float pausedAngleGR = 0.0;
BOOL timerLabelOption = true;
BOOL aniPause = false;
BOOL animation = true;

@implementation ECTViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];
    
}

- (void)resignActive {
    
    if ([_autoTimer isValid]) {
        
        [_autoTimer invalidate];
        
        _autoTimer = nil;
        
    }
    
}

- (void)active {
    
    [self.view setNeedsDisplay];
    
    if (notification) {
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    if (bgColorOption && pauseBool != true && afterRemainder && bgConSum != 0) {
        
        [self pushMessage];
        
        _autoTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
        
        if (afterRemainder == bgConSum) {
            
            [_autoTimer fire];
            
        }
        
    } else if (pauseBool != true && afterRemainder && bgConSum != 0) {
        
        [self pushMessage];
        
        _autoTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDownReverse) userInfo:nil repeats:YES];
        
        if (afterRemainder == bgConSum) {
            
            [_autoTimer fire];
            
        }
        
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _startButton.exclusiveTouch = YES;
    _pauseButton.exclusiveTouch = YES;
    _resetButton.exclusiveTouch = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignActive) name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(active) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    if (self.view.bounds.size.height < 568) {
        
        self.segment2.frame = CGRectMake(20, 360, 280, 25);
        
        self.segment3.frame = CGRectMake(20, 400, 280, 25);
        
        self.aniSegment.frame = CGRectMake(20, 440, 280, 25);
        
    }
    
    [[_startButton layer] setBorderWidth:0.5f];
    
    [[_startButton layer] setBorderColor:[UIColor grayColor].CGColor];
    
    [[_pauseButton layer] setBorderWidth:0.5f];
    
    [[_pauseButton layer] setBorderColor:[UIColor grayColor].CGColor];
    
    [[_resetButton layer] setBorderWidth:0.5f];
    
    [[_resetButton layer] setBorderColor:[UIColor grayColor].CGColor];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    self.displayLabel.hidden = NO;
    
    self.resetButton.enabled = NO;
    
    self.pauseButton.enabled = NO;
    
    self.displayLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:24];
    
    self.hourLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:24];
    
    self.minuteLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:24];
    
    self.secondLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:24];
    
    self.isRunning = false;
    
    bgColorOption = true;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (IBAction)startButton:(id)sender {
    
    int selectors = userHours + userMinutes + userSeconds;
    
    if (selectors == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please select a countdown time!" message:@"" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        
        [alert show];
        
    } else {
        
        backgroudTime = 0;
        
        pacManView.hidden = YES;
        
        angleGR = (percentageDone * (M_PI * 2.0));
        
        self.aniSegment.hidden = YES;
        
        if (animation) {
            
            if (self.view.bounds.size.height > 568) {
                
                pacManView = [[ECTProgressView alloc] initWithFrame:CGRectMake(100.0, 620.0, 580.0, 80.0)];
                
            } else if (self.view.bounds.size.height == 568) {
                
                pacManView = [[ECTProgressView alloc] initWithFrame:CGRectMake(-22.0, 400.0, 370.0, 100.0)];
                
            } else {
                
                pacManView = [[ECTProgressView alloc] initWithFrame:CGRectMake(-22.0, 320.0, 370.0, 100.0)];
                
            }
            
            [pacManView setBackgroundColor:[UIColor blackColor]];
            
            if (aniPause) {
                
                [pacManView setAngle:pausedAngleGR];
                
                [self.view addSubview:pacManView];
                
            } else {
                
                [pacManView setAngle:M_PI * 2.0];
                
                [self.view addSubview:pacManView];
                
            }
            
        }
        
        self.instructIndex.hidden = YES;
        
        self.displayLabel.hidden = NO;
        
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
        
        self.displayLabel.font = [self.displayLabel.font fontWithSize:58];
        
        if (bgColorOption == true && pauseBool != true) {
            
            [self.view setBackgroundColor:[UIColor greenColor]];
            
        } else if (bgColorOption == false && pauseBool != true) {
            
            [self.view setBackgroundColor:[UIColor redColor]];
            
        }
        
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
            
            [self pushMessage];
            
            _autoTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
            
            if (afterRemainder == bgConSum) {
                
                [_autoTimer fire];
                
            }
            
        } else {
            
            [self pushMessage];
            
            _autoTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDownReverse) userInfo:nil repeats:YES];
            
            if (afterRemainder == bgConSum) {
                
                [_autoTimer fire];
                
            }
            
        }
        
        pauseBool = false;
        
    }
    
}

- (void)pushMessage {
    
    notification = [[UILocalNotification alloc] init];
    
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:afterRemainder];
    
    notification.timeZone = [[NSCalendar currentCalendar] timeZone];
    
    notification.alertBody = NSLocalizedString(@"Your countdown has finished!", nil);
    
    [notification setSoundName: @"AudioServicesPlaySystemSound(1304)"];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
}

- (IBAction)pauseMeth:(id)sender {
    
    pausedAngleGR = 0.0;
    
    pausedAngleGR = angleGR;
    
    aniPause = true;
    
    if (notification) {
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    notification = nil;
    
    [_startButton setEnabled: YES];
    
    [_pauseButton setEnabled: NO];
    
    [_autoTimer invalidate];
    
    _autoTimer = nil;
    
    pauseBool = true;
    
    pauseTime = pauseTracker;
    
}

- (IBAction)resetButton:(id)sender {
    
    thisMagicMoment = nil;
    timeOfNoMagic = 0;
    lastMagicMoment = nil;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lastMagicMoment"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    pausedAngleGR = (M_PI * 2.0);
    
    aniPause = false;
    
    if (notification) {
        
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
        
    }
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    self.aniSegment.hidden = NO;
    
    self.displayLabel.text = @"";
    
    self.instructIndex.hidden = NO;
    
    self.segment2.hidden = NO;
    
    self.segment3.hidden = NO;
    
    pauseBool = false;
    
    afterRemainder = 0;
    
    pauseTracker = 0;
    
    bgConSum = 0;
    
    backgroudTime = 0;
    
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
    
    pacManView.hidden = YES;
    
    self.displayLabel.font = [self.displayLabel.font fontWithSize:24];
    
}

- (void)updateCountDown {
    
    if (self.view.bounds.size.height == 568) {
        if (afterRemainder > 3600) {
            self.displayLabel.frame = CGRectMake(10, 225, 280, 80);
        } else if (afterRemainder > 60) {
            self.displayLabel.frame = CGRectMake(19, 225, 280, 80);
        } else {
            self.displayLabel.frame = CGRectMake(23, 225, 280, 80);
        }
    } else if (self.view.bounds.size.height < 568) {
        if (afterRemainder > 3600) {
            self.displayLabel.frame = CGRectMake(10, 175, 280, 80);
        } else if (afterRemainder > 60) {
            self.displayLabel.frame = CGRectMake(19, 175, 280, 80);
        } else {
            self.displayLabel.frame = CGRectMake(23, 175, 280, 80);
        }
    }
    
    percentageDone = (float)afterRemainder / (float)bgConSum;
    
    if (aniPause) {
        
        angleGR = percentageDone * (M_PI * 2.0);
        
        aniPause = false;
        
    } else {
        
        angleGR = (percentageDone * (M_PI * 2.0));
        
    }
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [pacManView setAngle:angleGR];
    } completion:nil];
    
    pauseTracker++;
    
    afterRemainder--;
    
    if (afterRemainder > bgConSum * 0.80) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:(bgConSum + backgroudTime) / (5 + backgroudTime)];
        
        self.view.backgroundColor = [UIColor colorWithRed:173.0/255.0 green:255.0/255.0 blue:47.0/255.0 alpha:1];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder < bgConSum * 0.80 && afterRemainder > bgConSum * 0.60) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:(bgConSum + backgroudTime) / (5 + backgroudTime)];
        
        self.view.backgroundColor = [UIColor yellowColor];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder < bgConSum * 0.60 && afterRemainder > bgConSum * 0.40) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:(bgConSum + backgroudTime) / (5 + backgroudTime)];
        
        self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0/255.0 alpha:1];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder < bgConSum * 0.40 && afterRemainder > bgConSum * 0.20) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:(bgConSum + backgroudTime) / (5 + backgroudTime)];
        
        self.view.backgroundColor = [UIColor orangeColor];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder < bgConSum * 0.20 && afterRemainder > 0) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:(bgConSum + backgroudTime) / (5 + backgroudTime)];
        
        self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:69.0/255.0 blue:66.0/255.0 alpha:1];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder == 0) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:2.0];
        
        self.view.backgroundColor = [UIColor redColor];
        
        [UIView commitAnimations];
        
        [_startButton setTitle:NSLocalizedString(@"Start", @"Start It...") forState:UIControlStateNormal];
        
        [_startButton setEnabled: NO];
        
        [_pauseButton setEnabled: NO];
        
        [_autoTimer invalidate];
        
        _autoTimer = nil;
        
        pacManView.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done!" message:@"" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        
        [alert show];
        
        AudioServicesPlaySystemSound(1304);
        
        backgroudTime = 0;
        
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
    
    if (self.view.bounds.size.height == 568) {
        if (afterRemainder > 3600) {
            self.displayLabel.frame = CGRectMake(10, 225, 280, 80);
        } else if (afterRemainder > 60) {
            self.displayLabel.frame = CGRectMake(19, 225, 280, 80);
        } else {
            self.displayLabel.frame = CGRectMake(23, 225, 280, 80);
        }
    } else if (self.view.bounds.size.height < 568) {
        if (afterRemainder > 3600) {
            self.displayLabel.frame = CGRectMake(10, 175, 280, 80);
        } else if (afterRemainder > 60) {
            self.displayLabel.frame = CGRectMake(19, 175, 280, 80);
        } else {
            self.displayLabel.frame = CGRectMake(23, 175, 280, 80);
        }
    }
    
    percentageDone = (float)afterRemainder / (float)bgConSum;
    
    if (aniPause) {
        
        angleGR = percentageDone * (M_PI * 2.0);
        
        aniPause = false;
        
    } else {
        
        angleGR = (percentageDone * (M_PI * 2.0));
        
    }
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [pacManView setAngle:angleGR];
    } completion:nil];
    
    pauseTracker++;
    
    afterRemainder--;
    
    if (afterRemainder > bgConSum * 0.80) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:(bgConSum + backgroudTime) / (5 + backgroudTime)];
        
        self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:69.0/255.0 blue:66.0/255.0 alpha:1];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder < bgConSum * 0.80 && afterRemainder > bgConSum * 0.60) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:(bgConSum + backgroudTime) / (5 + backgroudTime)];
        
        self.view.backgroundColor = [UIColor orangeColor];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder < bgConSum * 0.60 && afterRemainder > bgConSum * 0.40) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:(bgConSum + backgroudTime) / (5 + backgroudTime)];
        
        self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:0/255.0 alpha:1];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder < bgConSum * 0.40 && afterRemainder > bgConSum * 0.20) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:(bgConSum + backgroudTime) / (5 + backgroudTime)];
        
        self.view.backgroundColor = [UIColor yellowColor];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder < bgConSum * 0.20 && afterRemainder > 0) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:(bgConSum + backgroudTime) / (5 + backgroudTime)];
        
        self.view.backgroundColor = [UIColor colorWithRed:173.0/255.0 green:255.0/255.0 blue:47.0/255.0 alpha:1];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder == 0) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:2.0];
        
        self.view.backgroundColor = [UIColor greenColor];
        
        [UIView commitAnimations];
        
        [_startButton setTitle:NSLocalizedString(@"Start", @"Start It...") forState:UIControlStateNormal];
        
        [_startButton setEnabled: NO];
        
        [_pauseButton setEnabled: NO];
        
        [_autoTimer invalidate];
        
        _autoTimer = nil;
        
        pacManView.hidden = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done!" message:@"" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
        
        [alert show];
        
        AudioServicesPlaySystemSound(1304);
        
        backgroudTime = 0;
        
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

- (IBAction)aniSegment:(id)sender {
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        
        animation = true;
        
    } else {
        
        animation = false;
        
    }
    
}

@end