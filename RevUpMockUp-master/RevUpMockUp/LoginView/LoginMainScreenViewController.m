//
//  LoginMainScreenViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 08/01/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "LoginMainScreenViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "LoginScreenViewController.h"
#import "SignUpViewController.h"
#import "SharedManager.h"

@interface LoginMainScreenViewController ()

- (IBAction)revUpAccountButtonClicked:(id)sender;
- (IBAction)createButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *revUpLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *createButton;

@end

@implementation LoginMainScreenViewController

#pragma mark - View Lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
   
}
-(void)configure{
    self.navigationItem.title = @"Login";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Back"
                                   style:UIBarButtonItemStylePlain
                                   target:nil
                                   action:nil];
    self.navigationItem.backBarButtonItem=backButton;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction Methods

- (IBAction)revUpAccountButtonClicked:(id)sender {
    LoginScreenViewController *loginScreenVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginScreenViewController"];
    [self.navigationController pushViewController:loginScreenVC animated:YES];
//    UINavigationController *loginScreenNavigation =
//    [[UINavigationController alloc] initWithRootViewController:loginScreenVC];
//
//    [self presentViewController:loginScreenNavigation animated:YES completion:nil];
}

- (IBAction)createButtonClicked:(id)sender {
    SignUpViewController *signUpVC = [[SharedManager sharedManager] signUpViewController];
    [self.navigationController pushViewController:signUpVC animated:YES];
//    UINavigationController *signUpNavigation = [[UINavigationController alloc] initWithRootViewController:signUpVC];
//    [self presentViewController:signUpNavigation animated:YES completion:nil];
}

@end
