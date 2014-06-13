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
    // config a toggle for this button for pause and start...
    IBOutlet UIButton *startButton;
    NSTimer *autoTimer;
    NSTimeInterval countDownInterval;
}
@end

@implementation ECTViewController

- (void)viewDidLoad

{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
}

- (void)didReceiveMemoryWarning

{
    
    [super didReceiveMemoryWarning];
    
}

- (IBAction)resetButton:(id)sender {
    [autoTimer invalidate];
    autoTimer = nil;
    self.view.backgroundColor = [UIColor whiteColor];
    self.displayLabel.text = @"00 h : 00 m : 00 s";
}

- (IBAction)startButton:(id)sender {
    countDownInterval = (NSTimeInterval)_countDownTimer.countDownDuration;
    remainder = countDownInterval;
    afterRemainder = countDownInterval - remainder % 60;
    bgConSum = afterRemainder;
    autoTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
}

- (void)updateCountDown {
    
    NSLog(@"%d", afterRemainder);
    
    afterRemainder --;
    
    if (afterRemainder > bgConSum * 0.75) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor yellowColor];
        
        [UIView commitAnimations];
    
    } else if (afterRemainder < bgConSum * 0.75 && afterRemainder > bgConSum / 2) {
    
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor orangeColor];
        
        [UIView commitAnimations];
    
    } else if (afterRemainder < bgConSum / 2 && afterRemainder > bgConSum * 0.25) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor blueColor];
        
        [UIView commitAnimations];
    
    } else if (afterRemainder < bgConSum * 0.25 && afterRemainder > 0) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
        self.view.backgroundColor = [UIColor purpleColor];
        
        [UIView commitAnimations];
        
    } else if (afterRemainder == 0) {
        
        [UIView beginAnimations:nil context:nil];
        
        [UIView setAnimationDuration:bgConSum / 5];
        
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

@end