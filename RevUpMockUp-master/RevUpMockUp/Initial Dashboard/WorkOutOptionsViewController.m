//
//  WorkOutOptionsViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 05/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "WorkOutOptionsViewController.h"
#import "InitialDashboardViewController.h"
#import "WalkingAssesmentViewController.h"
#import "FreeFormViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "SharedManager.h"
#import "OnBoardingViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface WorkOutOptionsViewController () <CBCentralManagerDelegate> {
    CBCentralManager *bluetoothManager;
    BOOL bluetoothEnabled;
}


-(void)slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;
- (IBAction)poundItClicked:(id)sender;
- (IBAction)freeformClicked:(id)sender;

- (IBAction)assessmentClicked:(id)sender;

@end

@implementation WorkOutOptionsViewController

#pragma mark - View Lifecycle Methods

-(void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}
-(void)configure{
    
    //Roshani - Read the JSON configurations to apply the UI changes
    
    self.navigationItem.title = @"Dashboard";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    UISwipeGestureRecognizer *swipeLeftAction = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    swipeLeftAction.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:swipeLeftAction];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    [self startBluetoothStatusMonitoring];


}
-(void)slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer{
    [UIView animateWithDuration:0.5 animations:^{
        InitialDashboardViewController *initialDashBoardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InitialDashboardViewController"];

        [self.navigationController pushViewController:initialDashBoardVC animated:YES];
        
    }];
    
}

#pragma mark - IBAction Methods

- (IBAction)poundItClicked:(id)sender {
    OnBoardingViewController *onboardingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OnBoardingViewController"];
    [self.navigationController pushViewController:onboardingVC animated:YES];
}

- (IBAction)freeformClicked:(id)sender {
    FreeFormViewController *freeFormVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FreeFormViewController"];
    [self.navigationController pushViewController:freeFormVC animated:YES];

}

- (IBAction)assessmentClicked:(id)sender {
    [self startBluetoothStatusMonitoring];
    //check if HRM is connected
    BOOL checkGPS = [self isGPSConnectionActive];
    if(!checkGPS) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bluetooth" message:@"Please turn on your GPS Connection!!!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];

    }
    else {
        WalkingAssesmentViewController *walkingAssesmentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WalkingAssesmentViewController"];
        [self.navigationController pushViewController:walkingAssesmentVC animated:YES];
    }
}

- (BOOL)isGPSConnectionActive {
    
    if([CLLocationManager locationServicesEnabled] &&
       [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        return true;
        } else {
            return false;
    }
}

- (void)startBluetoothStatusMonitoring {
    bluetoothManager = [[CBCentralManager alloc]
                        initWithDelegate:self
                        queue:dispatch_get_main_queue()
                        options:@{CBCentralManagerOptionShowPowerAlertKey: @(NO)}];
    bluetoothManager.delegate = self;
}

#pragma mark - CBCentralManagerDelegate Methods

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    if ([central state] == CBCentralManagerStatePoweredOn) {
        bluetoothEnabled = YES;
    }
    else {
        bluetoothEnabled = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bluetooth" message:@"Please turn on your bluetooth!!!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
}


//- (BOOL) isHeartRateMonitorConnected {
//    
//}

@end
