//
//  HRMDisconnectedViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 04/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "HRMDisconnectedViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "SharedManager.h"
#import "InitialDashboardViewController.h"

@interface HRMDisconnectedViewController () {
    
    __weak IBOutlet UIButton *reconnectButton;
    __weak IBOutlet UIView *disconnectedView;
    __weak IBOutlet UIView *hrmNotWornView;
}
- (IBAction)reconnectPressed:(id)sender;
- (IBAction)continuePressed:(id)sender;

@end

@implementation HRMDisconnectedViewController

#pragma mark - View Lifecycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configure{
    
    //Roshani - Read the JSON configurations to apply the UI changes
 
    self.navigationItem.title = @"Connect your HR Monitor";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    if(disconnectedView) {
        [hrmNotWornView removeFromSuperview];
    }
    else if(hrmNotWornView) {
        [disconnectedView removeFromSuperview];
        
    }
}

#pragma mark - IBAction Methods

- (IBAction)reconnectPressed:(id)sender {
    InitialDashboardViewController *initialDashboardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InitialDashboardViewController"];
    UINavigationController *initialDashboardNavigationVC = [[UINavigationController alloc] initWithRootViewController:initialDashboardVC];
    [self presentViewController:initialDashboardNavigationVC animated:YES completion:nil];
}

- (IBAction)continuePressed:(id)sender {
   
    
}
@end
