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

    // Why pointer...?
    NSString *testString = @"SETTINGS VIEW...";
    self.testLabelf.text = [testString stringByAppendingString:@"!"];
    self.testLabelf.text = [testString stringByReplacingOccurrencesOfString:@"..." withString:@"***"];

    /* !!! */

    // Why no pointer...?
    NSUInteger testStringLength = [testString length];
    NSLog(@"%d", testStringLength);
    
    BOOL isStringEqual = [testString isEqualToString:@"SETTINGS VIEW..."];
    NSLog(@" %s", isStringEqual ? "true" : "false");
    
    // Why a pointer...?
    NSURL *myURL = [NSURL URLWithString:@"http://developer.apple.com"];
    NSLog(@"%@", myURL);
    
    // ...
    
    // * means we are holding a ref. to the object of a class...
    // alloc will create an instance of the blueprint for the object...and we store that object in a proper var for memory...
    // alloc returns a ref. to the new object in memory...
    // init with init and it will return a ref. to the initiated object with the reference of it being in memory...
    UITextField *textField = [[UITextField alloc]init];
    textField.placeholder = @"First Name";
    textField.frame = CGRectMake(20, 150, 280, 31);
    textField.borderStyle = UITextBorderStyleRoundedRect;
    // Add a subview object so that you can program dynamic UI for IOS apps...
    // self refers to the view controller...
    // view refers to to view where our UI object will be placed...
    // addSubView means we are utilizing a function that will place the textField or any other element onto the view controller...
    // It's all about programming based on the UI events and understanding the syntax and the order of concepts etc...this shit's easy and rough...
    [self.view addSubview:textField];
    
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
