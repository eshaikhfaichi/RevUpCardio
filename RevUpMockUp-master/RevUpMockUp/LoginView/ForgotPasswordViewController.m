//
//  ForgotPasswordViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 18/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "LoginScreenViewController.h"
#import "SharedManager.h"


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
@interface ForgotPasswordViewController () <UITextFieldDelegate> {
    __weak IBOutlet UIButton *submitButton;
    __weak IBOutlet UITextField *emailTextField;
    __weak IBOutlet UITextField *verifyBirthDateTextField;
}
- (IBAction)submitClicked:(id)sender;

@end
@implementation ForgotPasswordViewController

#pragma mark - View Lifecycle Methods

- (void) viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void) configure {
    self.navigationItem.title = @"Forgot Password";
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
    emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"EMAIL" attributes:@{NSForegroundColorAttributeName: color}];
    
    verifyBirthDateTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"VERIFY DATE OF BIRTH" attributes:@{NSForegroundColorAttributeName: color}];
}

#pragma mark - IBAction Methods

- (IBAction)submitClicked:(id)sender {
   
}

-(void) dismissView {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Adjust view height according to keyboard height

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField== verifyBirthDateTextField && (IS_IPHONE_4 || IS_IPHONE_5))
    {
        [self keyBoardAppeared];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField== verifyBirthDateTextField && (IS_IPHONE_4 || IS_IPHONE_5))
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
                         self.view.frame = CGRectMake(frame.origin.x, frame.origin.y - 30, frame.size.width, frame.size.height);
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
                         self.view.frame = CGRectMake(frame.origin.x, frame.origin.y+ 30, frame.size.width, frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
