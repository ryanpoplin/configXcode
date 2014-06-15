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

- (IBAction)resetButton:(id)sender;

- (IBAction)startButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

@property (weak, nonatomic) IBOutlet UIDatePicker *countDownTimer;

@end
