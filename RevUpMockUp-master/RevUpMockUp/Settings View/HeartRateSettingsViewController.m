//
//  HeartRateSettingsViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 13/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "HeartRateSettingsViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "SharedManager.h"

@interface HeartRateSettingsViewController () <UITextFieldDelegate>

@end

@implementation HeartRateSettingsViewController

#pragma mark - View Lifecycle Methods

-(void) viewDidLoad {
    [super viewDidLoad];
    [self configure];
}


-(void) configure {
    self.navigationItem.title = @"Heart Rate";
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager]appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"DONE" style:UIBarButtonItemStylePlain target:self action:@selector(donePressed)];
}

#pragma mark - Button Action Methods

-(void) donePressed {
    
}

#pragma mark - TextField Delegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSString *message = nil;
    if(textField.tag == 1) {
        
        message = @"Changing this will affect your personalised workout. It's recommended that you complete an assessment instead.";
        
    }
    else if(textField.tag == 2) {
        message = @"Changing this will affect your personalised workout.";
    }
    
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                       message:message
                                      delegate:self
                             cancelButtonTitle:@"I understand"
                             otherButtonTitles:nil];
    
    [alert setTintColor:[UIColor grayColor]];

    [alert show];

    return YES;
}

@end
