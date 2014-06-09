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
    //...
    int halfWay;
    //...
    NSTimeInterval countDownInterval;
}
@end

// Our class implementation file...
@implementation ECTViewController

// Global and Static...

// Just a method...
// A custom method that inherits the viewDidLoad method from a superclass...
- (void)viewDidLoad
{
    // Local...
    [super viewDidLoad];
    // Store the data of the type NSString...
    // * refers that this var is pointer...
    // A.K.A refers to an object in memory...
    // NSString is class...
    NSString *excepappsString = @"by ExcepApps";
    // self refers to the view's controller class...
    // in the .h you define a prop. that refers to the UILabel object you created...
    // text is a prop. that comes with the label that you set string data to...
    // Instead of typeing out the prop, you can you use the assistive editor mode to drag and connect a ViewController object to the @interface in the .h file...
    self.excepappsString.text = excepappsString;
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
    //...
    halfWay = bgConSum / 2;
    //...
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
}

- (void)updateCountDown {
    NSLog(@"%d", afterRemainder);
    afterRemainder --;
    // CONFIG EXTRA BACKGROUND COLOR TRANS. OPTIONS...
    if (afterRemainder > halfWay) {
        [UIView animateWithDuration:3.0 animations:^{
            self.view.backgroundColor = [UIColor greenColor];
        }];
        [UIView commitAnimations];
    } else if (afterRemainder > 0) {
        [UIView animateWithDuration:3.0 animations:^{
            self.view.backgroundColor = [UIColor yellowColor];
        }];
        [UIView commitAnimations];
    } else if (afterRemainder <= 0) {
        [UIView animateWithDuration:3.0 animations:^{
            self.view.backgroundColor = [UIColor redColor];
        }];
        [UIView commitAnimations];
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
