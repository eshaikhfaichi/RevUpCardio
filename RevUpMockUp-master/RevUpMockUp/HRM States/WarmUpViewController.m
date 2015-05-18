//
//  WarmUpViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 17/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "WarmUpViewController.h"
#import "SharedManager.h"
#import "UIColor+ColorWithHexString.h"
#import "WalkingAssesmentViewController.h"

@interface WarmUpViewController() {
    __weak IBOutlet UILabel *countDownLabel;
    NSTimer *countDownTimer;
    int currentMinutes, currentSeconds;
    int secondsLeft;
    __weak IBOutlet UILabel *textLabel;
    __weak IBOutlet UIButton *continueButton;
}

-(void)start;
-(void)timerFired;

- (IBAction)continueButtonPressed:(id)sender;
@end


@implementation WarmUpViewController

#pragma mark - View Lifecycle Methods

- (void) viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

- (void) configure {
    
    self.navigationItem.title = @"Warmup";
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    
    [textLabel setText:@"- Walk for 5 minutes at a comfortable pace\n - When finished, continue on to Assessment"];
    
    currentMinutes = 5;
    currentSeconds = 00;
    [self start];
}

#pragma mark - Timer Events

-(void)start {
    countDownTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];

}

-(void)timerFired {
    if((currentMinutes > 0 || currentSeconds >= 0) && currentMinutes >= 0)
    {
        if(currentSeconds==0)
        {
            currentMinutes -= 1;
            currentSeconds = 59;
        }
        else if(currentSeconds > 0)
        {
            currentSeconds-= 1;
        }
        if(currentMinutes>-1)
            [countDownLabel setText:[NSString stringWithFormat:@"%02d:%02d",currentMinutes,currentSeconds]];
    }
    else
    {
        [countDownTimer invalidate];
    }

}

#pragma mark - IBAction Methods

- (IBAction)continueButtonPressed:(id)sender {
    WalkingAssesmentViewController *walkingAssesmentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WalkingAssesmentViewController"];
    UINavigationController *walkingAssesmentNavigation = [[UINavigationController alloc] initWithRootViewController:walkingAssesmentVC];
    [self presentViewController:walkingAssesmentNavigation animated:YES completion:nil];
}

@end
