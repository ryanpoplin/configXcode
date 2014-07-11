

//
//  ECTSettingsViewController.h
//  Color Countdown
//
//  Created by Byrdann Fox on 7/10/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECTSettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSegment;
- (IBAction)colorSegment:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *timerNumberSegment;
- (IBAction)timerNumberSegment:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *aniSegment;
- (IBAction)aniSegment:(id)sender;

@end

