//
//  ECTTestViewViewController.m
//  TImeTime
//
//  Created by Byrdann Fox on 6/9/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

// IT'S A TALL ORDER!!!

#import "ECTTestViewViewController.h"
#import "ECTTimerDetailViewController.h"

@interface ECTTestViewViewController ()

/* PROPS! */
@property (nonatomic, strong) IBOutlet UILabel *label;

@end

@implementation ECTTestViewViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Preparing for segue with identifier: %@", segue.identifier);
    // FIGURE OUT THE 0 RETURN FOR THIS CONDITION...
    /*if ([segue.identifier isEqualToString:@"pushDetial"]) {*/
        ECTTimerDetailViewController *viewController = segue.destinationViewController;
        viewController.timerModel = self.timerModel;
    // }
}

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
    NSLog(@"VIEW IS LOADED...");
    
    [self setupModel];
    
    self.title = @"ROOT";
    
}

- (void)setupModel
{
    self.timerModel = [[ECTTimerModel alloc]initWithCoffeeName:@"Columbian" duration:240];
}

- (void)setTimerModel:(ECTTimerModel *)timerModel
{
    _timerModel = timerModel;
    [self updateUserInterface];
}

-(void)updateUserInterface
{
    self.label.text = self.timerModel.coffeeName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* BUTTON WAS PRESSED... */

- (IBAction)buttonWasPressed:(id)sender
{
    NSLog(@"Button was pressed...");
    NSDate *date = [NSDate date];
    // Label is the new prop. we just created...
    self.label.text = [NSString stringWithFormat:@"Button was pressed at %@", date];
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