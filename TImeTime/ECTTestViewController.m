//
//  ECTTestViewController.m
//  Color Countdown
//
//  Created by Byrdann Fox on 7/8/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import "ECTTestViewController.h"

@interface ECTTestViewController ()



@end

@implementation ECTTestViewController

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
    
    // command + /
    
    NSString *myString = @"Objective-C and Swift...";
    // self.testLabel.text = [myString stringByAppendingString:@" and Swift..."];
    
    self.testLabel.text = [myString stringByReplacingOccurrencesOfString:@"and" withString:@"n"];
    
//    NSUInteger stringLength = [myString length];
//    // the view controller must be segued to...
//    NSLog(@"%d", stringLength);
//    
//    BOOL isStringEqual = [myString isEqualToString:@"Nothing..."];
//    NSLog(@"%hhd", isStringEqual);
//    
//    NSURL *testURL = [NSURL URLWithString:@"http://www.oakleafsd.com"];
//    NSLog(@"%@", testURL);
    
    
    
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

@end
