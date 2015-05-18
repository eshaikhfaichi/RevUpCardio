//
//  SkipWarmUpViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 23/04/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "SkipWarmUpViewController.h"
#import "IntervalWorkoutViewController.h"
#import "SharedManager.h"
#import "UIColor+ColorWithHexString.h"

@interface SkipWarmUpViewController () {
    
    __weak IBOutlet UIButton *resumeButton;
}
- (IBAction)skipWarmupClicked:(id)sender;

@end

@implementation SkipWarmUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
    // Do any additional setup after loading the view.
}

- (void) configure {
    self.navigationItem.title = @"RevUp";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    
    self.skipWarmupButton.layer.borderColor=[[UIColor blackColor] CGColor];
    self.skipWarmupButton.layer.borderWidth= 1.0f;
    resumeButton.layer.borderColor=[[UIColor blackColor] CGColor];
    resumeButton.layer.borderWidth= 1.0f;
    
    [self.skipWarmupButton setBackgroundColor:[UIColor colorWithHexString:@"0x292929"]];
    
    [resumeButton setBackgroundColor:[UIColor colorWithHexString:@"0x292929"]];
    
    if([[SharedManager sharedManager] isFreeformScreen] == YES) {
        [self.skipWarmupButton setTitle:@"Skip Cool Down" forState:UIControlStateNormal];
        [[SharedManager sharedManager] setIsFreeformScreen:NO];
        
    }
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)skipWarmupClicked:(id)sender {
    IntervalWorkoutViewController *intervalWorkoutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"IntervalWorkoutViewController"];
    UINavigationController *intervalWorkoutNavigation = [[UINavigationController alloc] initWithRootViewController:intervalWorkoutVC];
    [self presentViewController:intervalWorkoutNavigation animated:YES completion:nil];
    
}
@end
