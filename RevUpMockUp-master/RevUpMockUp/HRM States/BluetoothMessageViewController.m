//
//  BluetoothMessageViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 02/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "BluetoothMessageViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "SharedManager.h"

@interface BluetoothMessageViewController ()


@end

@implementation BluetoothMessageViewController

#pragma mark - View Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configure];
    // Do any additional setup after loading the view.
}

-(void)configure{
    
    //Roshani - Read the JSON configurations to apply the UI changes
    
    self.navigationItem.title = @"Connect your HR Monitor";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
