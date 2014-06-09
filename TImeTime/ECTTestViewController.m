//
//  ECTTestViewController.m
//  TImeTime
//
//  Created by Byrdann Fox on 6/9/14.
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
    // Create a new class and associate it with the relevant view controller...
    // Drag or create a view controller element...
    // Enter the Tuxedo mode and drag and drop the to that class's .h file and connect it to the @interface for a new prop. creation to take place...
    
    // [testString(object we sending the message to...) stringByAppendingString:(Here's the method name...)@""(Here's the literal value we are passing to the method as an arguement...)];
    
    /* !!! */
    
    NSString *testString = @"SETTINGS VIEW...";
    self.testLabelf.text = [testString stringByAppendingString:@"!"];

    /* !!! */

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
