//
//  ECTViewController.h
//  TImeTime
//
//  Created by Byrdann Fox on 6/9/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import <UIKit/UIKit.h>

// TESTING GLOBAL...
// UIDatePicker *picker;

@interface ECTViewController : UIViewController

// WHAT KIND OF PROP. DO I NEED FOR THE ANIMATION???

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;

- (IBAction)resetButton:(id)sender;

- (IBAction)startButton:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSegment;

@property (weak, nonatomic) IBOutlet UISlider *hourSlider;

@property (weak, nonatomic) IBOutlet UISlider *minuteSlider;

@property (weak, nonatomic) IBOutlet UISlider *secondsSlider;

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

// FIX THIS...
@property (weak, nonatomic) IBOutlet UISegmentedControl *testerSegment;

@property (weak, nonatomic) IBOutlet UILabel *hourLabel;

- (IBAction)hoursMoved:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;

- (IBAction)minutesMoved:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

- (IBAction)secondsMoved:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

- (IBAction)pauseMeth:(id)sender;

@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backgroundTaskIdentifier;

@property (nonatomic, strong) NSTimer *autoTimer;

@end