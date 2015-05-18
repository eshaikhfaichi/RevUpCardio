//
//  BluetoothSuccessViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 02/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "BluetoothSuccessViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "HYCircleLoadingView.h"
#import "SharedManager.h"
#import "InitialDashboardViewController.h"

@interface BluetoothSuccessViewController () {
    __weak IBOutlet HYCircleLoadingView *loadingView;
    __weak IBOutlet UILabel *message;
}

@end

@implementation BluetoothSuccessViewController

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
    
    [loadingView startAnimation];
    self.navigationItem.title = @"Connect your HR Monitor";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    
    [self performSelector:@selector(showDashboard) withObject:nil afterDelay:10.0];

   
    
    //If HRM is connected
//    if(loadingView) {
//        [loadingView removeFromSuperview];
//        [message setText:@"Success"];
//    }else {
//        [message setText:@"Sorry we are having trouble. Lets reconnect your heart rate monitor."];
//        
//    }
}

- (void) showDashboard {
    InitialDashboardViewController *initialDashboardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InitialDashboardViewController"];
    UINavigationController *DashboardNavigation = [[UINavigationController alloc] initWithRootViewController:initialDashboardVC];
    [self presentViewController:DashboardNavigation animated:YES completion:nil];
}

@end
