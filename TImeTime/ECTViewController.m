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
    int afterRemainder;
    int remainder;
    int bgConSum;
    int threeFourthsWay;
    int halfWay;
    int quarterWay;
    NSTimer *autoTimer;
    NSTimeInterval countDownInterval;
}
@end

@implementation ECTViewController

- (void)viewDidLoad

{
    
    [super viewDidLoad];
    
    // NSString *excepappsString = @"by ExcepApps";
    // self.excepappsString.text = excepappsString;

}

- (void)didReceiveMemoryWarning

{
    
    [super didReceiveMemoryWarning];
    
}

- (IBAction)startButton:(id)sender {
    countDownInterval = (NSTimeInterval)_countDownTimer.countDownDuration;
    remainder = countDownInterval;
    afterRemainder = countDownInterval - remainder%60;
    bgConSum = afterRemainder;
    threeFourthsWay = bgConSum * 0.75;
    halfWay = bgConSum / 2;
    quarterWay = bgConSum * 0.25;
    autoTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
}

- (void)updateCountDown {
    NSLog(@"%d", afterRemainder);
    afterRemainder --;
    if (afterRemainder > threeFourthsWay) {
        [UIView animateWithDuration:1.0 animations:^{
            self.view.backgroundColor = [UIColor greenColor];
        }];
        [UIView commitAnimations];
    } else if (afterRemainder > halfWay) {
        [UIView animateWithDuration:1.0 animations:^{
            self.view.backgroundColor = [UIColor blueColor];
        }];
        [UIView commitAnimations];
    } else if (afterRemainder > quarterWay) {
        [UIView animateWithDuration:1.0 animations:^{
            self.view.backgroundColor = [UIColor yellowColor];
        }];
        [UIView commitAnimations];
    } else if (afterRemainder > 0) {
        [UIView animateWithDuration:1.0 animations:^{
            self.view.backgroundColor = [UIColor orangeColor];
        }];
        [UIView commitAnimations];
    } else if (afterRemainder == 0) {
        [UIView animateWithDuration:1.0 animations:^{
            self.view.backgroundColor = [UIColor redColor];
        }];
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

@end