//
//  ECTTestViewController.h
//  TImeTime
//
//  Created by Byrdann Fox on 6/9/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECTTestViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *testLabelf;
@property (weak, nonatomic) IBOutlet UITextField *testTextField;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UILabel *anotherLabel;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timeRemaining;
-(IBAction)buttonPressed:(id)sender;

@end
