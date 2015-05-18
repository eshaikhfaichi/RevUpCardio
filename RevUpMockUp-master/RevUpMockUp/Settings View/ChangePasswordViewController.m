//
//  ChangePasswordViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 16/04/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "SharedManager.h"
#import "UIColor+ColorWithHexString.h"

@interface ChangePasswordViewController () {
    
    __weak IBOutlet UITextField *newPasswordTextField;
    __weak IBOutlet UITextField *confirmNewPasswordTextField;
    __weak IBOutlet UITextField *currentPasswordTextField;
}

@end
@implementation ChangePasswordViewController

#pragma mark - View Lifecycle Methods

-(void) viewDidLoad {
    [self configure];
    
}
-(void) configure {
    self.navigationItem.title = @"Change Password";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    
    currentPasswordTextField.layer.borderColor=[[UIColor whiteColor] CGColor];
    currentPasswordTextField.layer.borderWidth= 1.0f;
    
    newPasswordTextField.layer.borderColor=[[UIColor whiteColor] CGColor];
    newPasswordTextField.layer.borderWidth= 1.0f;
    
    confirmNewPasswordTextField.layer.borderColor=[[UIColor whiteColor] CGColor];
    confirmNewPasswordTextField.layer.borderWidth= 1.0f;
    
    currentPasswordTextField.layer.cornerRadius=3.0;
    currentPasswordTextField.clipsToBounds=YES;
    
    newPasswordTextField.layer.cornerRadius=3.0;
    newPasswordTextField.clipsToBounds=YES;
    
    confirmNewPasswordTextField.layer.cornerRadius=3.0;
    confirmNewPasswordTextField.clipsToBounds=YES;
    
    
    UIColor *color = [UIColor whiteColor];
    
    NSAttributedString *currentPasswordString = [[NSAttributedString alloc] initWithString:@"  CURRENT PASSWORD" attributes:@{ NSForegroundColorAttributeName :color }];
    
    NSAttributedString *newPasswordString = [[NSAttributedString alloc] initWithString:@"  NEW PASSWORD" attributes:@{ NSForegroundColorAttributeName : color }];
    
    NSAttributedString *confirmNewPasswordString = [[NSAttributedString alloc] initWithString:@"  CONFIRM NEW PASSWORD" attributes:@{ NSForegroundColorAttributeName : color }];

    
    currentPasswordTextField.attributedPlaceholder = currentPasswordString;
    newPasswordTextField.attributedPlaceholder = newPasswordString;
    confirmNewPasswordTextField.attributedPlaceholder = confirmNewPasswordString;

    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"DONE" style:UIBarButtonItemStyleDone target:self action:@selector(doneTapped)];
    
    self.navigationItem.rightBarButtonItem = doneButton;

}

-(void) doneTapped {
    
}
@end
