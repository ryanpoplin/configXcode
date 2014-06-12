//
//  ECTTimerEditViewController.m
//  TImeTime
//
//  Created by Byrdann Fox on 6/11/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import "ECTTimerEditViewController.h"

@interface ECTTimerEditViewController ()

@end

@implementation ECTTimerEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSInteger numberOfMinutes = self.timerModel.duration / 60;
    NSInteger numberOfSeconds = self.timerModel.duration % 60;
    
    self.nameField.text = self.timerModel.coffeeName;
    self.minutesLabel.text = [NSString stringWithFormat:@"%d Minutes", numberOfMinutes];
    self.secondsLabel.text = [NSString stringWithFormat:@"%d Seconds", numberOfSeconds];
    self.minutesSlider.value = numberOfMinutes;
    self.secondsSlider.value = numberOfSeconds;
}

-(IBAction)sliderValueChanged:(id)sender
{
    NSInteger numberOfMinutes = (NSInteger)self.minutesSlider.value;
    NSInteger numberOfSeconds = (NSInteger)self.secondsSlider.value;
    self.minutesLabel.text = [NSString stringWithFormat:@"%d Minutes", numberOfMinutes];
    self.secondsLabel.text = [NSString stringWithFormat:@"%d Seconds", numberOfSeconds];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancelButtonWasPressed:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)doneButtonWasPressed:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
