//
//  ECTViewController.m
//  TImeTime
//
//  Created by Byrdann Fox on 6/9/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import "ECTViewController.h"

@interface ECTViewController ()
{
    
    int userHours;
    
    int userMinutes;
    
    int userSeconds;
    
    int convertedHours;
    
    int convertedMinutes;
    
    int convertedSeconds;
    
    int afterRemainder;
   
    int remainder;
    
    int bgConSum;
    
    IBOutlet UIButton *startButton;
    
    NSTimer *autoTimer;
    
    NSTimeInterval countDownInterval;

}

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic) NSTimeInterval totalTime;
@property (nonatomic) BOOL isRunning;
@property (nonatomic, strong) void (^updateBlock)();

@end

@implementation ECTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.isRunning = false;
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
}

- (IBAction)startButton:(id)sender {
    
    self.startTime = [[NSDate alloc] init];
    
    self.startTime = [NSDate date];
    
    // FOR CLARITY...
    
    if (userHours == 0) {
        
        convertedHours = 0;
        
    } else {
    
        convertedHours = userHours * (60 * 60);
        
    }
    
    if (userMinutes == 0) {
        
        userMinutes = 0;
        
    } else {
        
        convertedMinutes = userMinutes * 60;
        
    }
    
    if (userSeconds == 0) {
        
        convertedSeconds = 0;
        
    } else {
        
        convertedSeconds = userSeconds;
        
    }
    
    self.totalTime = convertedHours + convertedMinutes + convertedSeconds;
    
    self.isRunning = !self.isRunning;
    
    if (self.isRunning == false) {
        
        [startButton setTitle:NSLocalizedString(@"Start", @"Start It...") forState:UIControlStateNormal];
        
    } else {
        
        [self.view setBackgroundColor:[UIColor greenColor]];
        
        [startButton setTitle:NSLocalizedString(@"Pause", @"Pause It...") forState: UIControlStateNormal];
        
    }

    // countDownInterval = (NSTimeInterval)_countDownTimer.countDownDuration;
    
    countDownInterval = convertedHours + convertedMinutes + convertedSeconds;
    
    remainder = countDownInterval;
    
    // afterRemainder = countDownInterval - remainder % 60;
    
    afterRemainder = countDownInterval;
    
    bgConSum = afterRemainder;
    
    autoTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
    
}

/* RESET METHOD... */

- (IBAction)resetButton:(id)sender {
    
    [autoTimer invalidate];
    
    autoTimer = nil;
    
    [UIView beginAnimations:nil context:nil];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [startButton setTitle:NSLocalizedString(@"Start", @"Start It...") forState:UIControlStateNormal];
    
    self.isRunning = false;
    
    self.displayLabel.text = @"00 h : 00 m : 00 s";
    
}

- (void)updateCountDown {
    
    [self updateCountDown2];
    
    NSLog(@"%d", afterRemainder);
    
    // MITIGATE...
    
    afterRemainder--;
    
    if (afterRemainder > bgConSum * 0.75) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor colorWithRed:173.0/255.0 green:255.0/255.0 blue:47.0/255.0 alpha:1];
        
        [UIView commitAnimations];
    
    } else if (afterRemainder < bgConSum * 0.75 && afterRemainder > bgConSum / 2) {
    
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor yellowColor];
        
        [UIView commitAnimations];
    
    } else if (afterRemainder < bgConSum / 2 && afterRemainder > bgConSum * 0.25) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:174.0/255.0 blue:66.0/255.0 alpha:1];
        
        [UIView commitAnimations];
    
    } else if (afterRemainder < bgConSum * 0.25 && afterRemainder > 0) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor orangeColor];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder == 0) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:2.0];
        
        self.view.backgroundColor = [UIColor redColor];
        
        [UIView commitAnimations];
        
        [autoTimer invalidate];
        
        autoTimer = nil;
    
    }
    
    int hours = (int)(afterRemainder/(60*60));
    
    int mins = (int)(((int)afterRemainder/60)-(hours*60));
    
    int secs = (int)(((int)afterRemainder-(60*mins)-(60*hours*60)));
    
    if (hours != 0 && mins != 0 && secs != 0) {
    
        NSString *displayText = [[NSString alloc] initWithFormat:@"%2u h : %2u m : %02u s", hours, mins, secs];
        
        self.displayLabel.text = displayText;
    
    } else if (hours == 0 && mins != 0) {
    
        NSString *displayText = [[NSString alloc] initWithFormat:@"%2u m : %02u s", mins, secs];
        
        self.displayLabel.text = displayText;
    
    } else if (hours == 0 && mins == 0 && secs >= 0) {
    
        NSString *displayText = [[NSString alloc] initWithFormat:@"%2u s", secs];
        
        self.displayLabel.text = displayText;

    }

}

- (void)updateCountDown2
{

    NSTimeInterval elapsedTime = -[self.startTime timeIntervalSinceNow];
    
    CGFloat elapsedPercent = elapsedTime / self.totalTime;
    
    NSLog(@"Elapsed Percent: %f", elapsedPercent);

}

- (IBAction)hoursMoved:(id)sender {
    
    UISlider *hourSlider = (UISlider *)sender;
    NSString *sliderValueAsStringHours = [NSString stringWithFormat:@"%d Hours", (int)[hourSlider value]];
    self.hourLabel.text = sliderValueAsStringHours;
    userHours = (int)[hourSlider value];
    
}

- (IBAction)minutesMoved:(id)sender {

    UISlider *minuteSlider = (UISlider *)sender;
    NSString *sliderValueAsStringMinutes = [NSString stringWithFormat:@"%d Minutes", (int)[minuteSlider value]];
    self.minuteLabel.text = sliderValueAsStringMinutes;
    userMinutes = (int)[minuteSlider value];

}

- (IBAction)secondsMoved:(id)sender {

    UISlider *secondSlider = (UISlider *)sender;
    NSString *sliderValueAsStringSeconds = [NSString stringWithFormat:@"%d Seconds", (int)[secondSlider value]];
    self.secondLabel.text = sliderValueAsStringSeconds;
    userSeconds = (int)[secondSlider value];
    
}

@end

