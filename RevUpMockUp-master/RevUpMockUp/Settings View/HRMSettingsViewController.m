//
//  HRMSettingsViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 13/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "HRMSettingsViewController.h"
#import "SharedManager.h"
#import "UIColor+ColorWithHexString.h"

@interface HRMSettingsViewController () {
    
    __weak IBOutlet UIButton *disconnectButton;
}
- (IBAction)disconnectPressed:(id)sender;

@end

@implementation HRMSettingsViewController

#pragma mark - View Lifecycle Methods

-(void) viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void) configure {
   
    self.navigationItem.title = @"Heart Monitor";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"DONE" style:UIBarButtonItemStylePlain target:self action:@selector(donePressed)];
    
}
    
#pragma mark - Button Action Methods

-(void) donePressed {
    
}

- (IBAction)disconnectPressed:(id)sender {
}
@end
