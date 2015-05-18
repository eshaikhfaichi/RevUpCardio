//
//  AfterLoginViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 09/01/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "AfterLoginViewController.h"
#import "BluetoothMessageViewController.h"
#import "BluetoothSuccessViewController.h"
#import "InitialDashboardViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface AfterLoginViewController () {
    CBCentralManager *bluetoothManager;
    BOOL bluetoothEnabled;
}

- (IBAction)continueButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UITextField *wahooMonitorLabel;
@property (weak, nonatomic) IBOutlet UITextField *polarMonitorLabel;

@end

@implementation AfterLoginViewController

#pragma mark - View Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    self.wahooMonitorLabel.layer.cornerRadius=3.0;
    self.wahooMonitorLabel.clipsToBounds=YES;
    self.wahooMonitorLabel.layer.borderColor=[[UIColor whiteColor] CGColor];
    self.wahooMonitorLabel.layer.borderWidth= 1.0f;


    self.polarMonitorLabel.layer.cornerRadius=3.0;
    self.polarMonitorLabel.clipsToBounds=YES;
    self.polarMonitorLabel.layer.borderColor=[[UIColor whiteColor] CGColor];
    self.polarMonitorLabel.layer.borderWidth= 1.0f;


    self.continueButton.layer.cornerRadius=3.0;
    self.continueButton.clipsToBounds=YES;
    [self startBluetoothStatusMonitoring];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    }
}


#pragma mark - IBAction Methods

- (IBAction)continueButtonClicked:(id)sender {
//    if(bluetoothEnabled) {
//        InitialDashboardViewController *bluetoothMessageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InitialDashboardViewController"];
//        UINavigationController *bluetoothNavigationVC = [[UINavigationController alloc] initWithRootViewController:bluetoothMessageVC];
//        [self presentViewController:bluetoothNavigationVC animated:YES completion:nil];
//    }
//    else {
        BluetoothSuccessViewController *bluetoothMessageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BluetoothSuccessViewController"];
        UINavigationController *bluetoothNavigationVC = [[UINavigationController alloc] initWithRootViewController:bluetoothMessageVC];
        [self presentViewController:bluetoothNavigationVC animated:YES completion:nil];
   // }
}
@end
