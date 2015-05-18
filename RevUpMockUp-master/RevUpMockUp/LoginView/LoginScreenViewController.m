//
//  LoginScreenViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 08/01/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//


#import "LoginScreenViewController.h"
#import "InitialDashboardViewController.h"
#import "ForgotPasswordViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "SharedManager.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )


@interface LoginScreenViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)forgotPasswordClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation LoginScreenViewController

#pragma mark - View Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void)configure {
    
    //Roshani - Read the JSON configurations to apply the UI changes

    self.navigationItem.title = @"Login";

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Back"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(dismissView)];
    self.navigationItem.leftBarButtonItem = backButton;
   
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
   
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    UIColor *color = [UIColor whiteColor];
    self.emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"EMAIL" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"PASSWORD" attributes:@{NSForegroundColorAttributeName: color}];
}
-(void) dismissView {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextviewDelegate Methods

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - IBAction Methods

- (IBAction)loginButtonClicked:(id)sender {
    InitialDashboardViewController *bluetoothMessageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InitialDashboardViewController"];
    UINavigationController *bluetoothNavigationVC = [[UINavigationController alloc] initWithRootViewController:bluetoothMessageVC];
    [self presentViewController:bluetoothNavigationVC animated:YES completion:nil];
}

- (IBAction)forgotPasswordClicked:(id)sender {
    ForgotPasswordViewController *forgotPasswordVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    [self.navigationController pushViewController:forgotPasswordVC animated:YES];
}

#pragma mark - Adjust view height according to keyboard height

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField== self.passwordTextField && (IS_IPHONE_4 || IS_IPHONE_5))
    {
        [self keyBoardAppeared];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField== self.passwordTextField && (IS_IPHONE_4 || IS_IPHONE_5))
    {
        [self keyBoardDisappeared];
    }
}


-(void) keyBoardAppeared
{
    CGRect frame = self.view.frame;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = CGRectMake(frame.origin.x, frame.origin.y - 20, frame.size.width, frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(void) keyBoardDisappeared
{
    CGRect frame = self.view.frame;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = CGRectMake(frame.origin.x, frame.origin.y+ 20, frame.size.width, frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                     }];
}



@end
