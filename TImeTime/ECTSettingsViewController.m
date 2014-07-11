

//
//  ECTSettingsViewController.m
//  Color Countdown
//
//  Created by Byrdann Fox on 7/10/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import "ECTSettingsViewController.h"
#import "ECTAppDelegate.h"

@interface ECTSettingsViewController ()

@end

@implementation ECTSettingsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)colorSegment:(id)sender {

    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    if (selectedSegment == 0) {
        bgColorOption = true;
    } else {
        bgColorOption = false;
    }
    
}

- (IBAction)timerNumberSegment:(id)sender {
    
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
        NSLog(@"YO...");
    } else {
        NSLog(@"NO...");
    }

}


@end

