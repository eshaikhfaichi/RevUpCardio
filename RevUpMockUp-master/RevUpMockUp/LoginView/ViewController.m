//
//  ViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 07/01/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "ViewController.h"
#import "LoginMainScreenViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "SharedManager.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property (nonatomic, retain) CLLocationManager *locationManager;
- (IBAction)okPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@end

@implementation ViewController

#pragma mark - View Lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configure];

      // Do any additional setup after loading the view, typically from a nib.
}

-(void)configure{
    if(!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        
    }
    self.locationManager.delegate = self;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction Method

- (IBAction)okPressed:(id)sender {
    LoginMainScreenViewController *loginMainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginMainScreenViewController"];
    UINavigationController *loginMainNavigation = [[UINavigationController alloc] initWithRootViewController:loginMainVC];
    [self presentViewController:loginMainNavigation animated:YES completion:nil];

    self.locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.locationManager = nil;
    
    if([CLLocationManager locationServicesEnabled]) {
       
    }
    [self.locationManager stopUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"error:%@",error);
}




@end
