//
//  ECTTimerEditViewController.h
//  TImeTime
//
//  Created by Byrdann Fox on 6/11/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECTTimerModel.h"

@interface ECTTimerEditViewController : UIViewController

@property (nonatomic, strong) ECTTimerModel *timerModel;

@property (nonatomic, strong) IBOutlet UITextField *nameField;

// NOTICE THAT THE LABEL AND THE SLIDER PROPS. DO NOT NEED TO BE DECLARED IN ANY PARTICULAR ORDER AS THEY ARE LAYED OUT UNTO THE VIEWCONTROLLER...

@property (nonatomic, strong) IBOutlet UILabel *minutesLabel;

@property (nonatomic, strong) IBOutlet UILabel *secondsLabel;

@property (nonatomic, strong) IBOutlet UISlider *minutesSlider;

@property (nonatomic, strong) IBOutlet UISlider *secondsSlider;

-(IBAction)cancelButtonWasPressed:(id)sender;

-(IBAction)doneButtonWasPressed:(id)sender;

-(IBAction)sliderValueChanged:(id)sender;

@end
