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

-(IBAction)cancelButtonWasPressed:(id)sender;

-(IBAction)doneButtonWasPressed:(id)sender;

@end
