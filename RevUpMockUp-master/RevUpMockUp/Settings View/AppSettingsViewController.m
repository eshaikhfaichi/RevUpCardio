//
//  AppSettingsViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 16/04/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "AppSettingsViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "HeartRateSettingsViewController.h"
#import "HRMSettingsViewController.h"
#import "SharedManager.h"

@interface AppSettingsViewController () {
    
}
- (IBAction)heartMonitorClicked:(id)sender;
- (IBAction)heartRateClicked:(id)sender;

@end
@implementation AppSettingsViewController


-(void) viewDidLoad {
    [self configure];
}
-(void) configure {
    self.navigationItem.title = @"App Settings";
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager]appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"DONE" style:UIBarButtonItemStyleDone target:self action:@selector(donePressed)];
}


- (IBAction)heartMonitorClicked:(id)sender {
    HRMSettingsViewController *hrmSettingsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HRMSettingsViewController"];
    [self.navigationController pushViewController:hrmSettingsVC animated:YES];
}

- (IBAction)heartRateClicked:(id)sender {
    HeartRateSettingsViewController *heartRateVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HeartRateSettingsViewController"];
    [self.navigationController pushViewController:heartRateVC animated:YES];
}

-(void) donePressed {
    
}

@end
