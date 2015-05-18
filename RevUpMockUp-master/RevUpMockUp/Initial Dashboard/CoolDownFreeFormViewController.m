//
//  CoolDownFreeFormViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 08/05/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "CoolDownFreeFormViewController.h"
#import "SharedManager.h"
#import "UIColor+ColorWithHexString.h"
#import "SwipeWarmupViewController.h"

@interface CoolDownFreeFormViewController ()
- (IBAction)swipeButtonPressed:(id)sender;

@end

@implementation CoolDownFreeFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
    // Do any additional setup after loading the view.
}

-(void) configure {
    self.navigationItem.title = @"Free Form Workout";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)swipeButtonPressed:(id)sender {
    SwipeWarmupViewController *swipeWarmUpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SwipeWarmupViewController"];
    [self.navigationController pushViewController:swipeWarmUpVC animated:YES];
    [swipeWarmUpVC.skipWarmUpButton setTitle: @"Skip Cool Down" forState: UIControlStateNormal];

}
@end
