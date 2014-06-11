//
//  ECTTimerDetailViewController.m
//  TImeTime
//
//  Created by Byrdann Fox on 6/10/14.
//  Copyright (c) 2014 ExcepApps. All rights reserved.
//

#import "ECTTimerDetailViewController.h"

@interface ECTTimerDetailViewController ()

@property (nonatomic, strong) IBOutlet UILabel *durationLabel;
@end

@implementation ECTTimerDetailViewController

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
    // self.title = @"DETAIL";
    self.title = self.timerModel.coffeeName;
    
    // !!!
    
    // ADD HOUR...
    
    // %d hour
    
    // self.timerModel.duration (something...),
    
    // !!!

    // ADD HOURS...
    
    self.durationLabel.text = [NSString stringWithFormat:@"%d mins %d secs", self.timerModel.duration / 60, self.timerModel.duration % 60];
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
