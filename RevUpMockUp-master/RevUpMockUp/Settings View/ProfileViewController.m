//
//  ProfileViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 16/04/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "ProfileViewController.h"
#import "ChangePasswordViewController.h"
#import "SharedManager.h"
#import "UIColor+ColorWithHexString.h"

@interface ProfileViewController () 

- (IBAction)changePasswordClicked:(id)sender;
@end

@implementation ProfileViewController

-(void) viewDidLoad {
    [self configure];
}
-(void) configure {
    self.navigationItem.title = @"Profile";
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager]appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"DONE" style:UIBarButtonItemStyleDone target:self action:@selector(donePressed)];

}

- (IBAction)changePasswordClicked:(id)sender {
    ChangePasswordViewController *changePasswordVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    [self.navigationController pushViewController:changePasswordVC animated:YES];
}

-(void) donePressed {
    
}
@end
