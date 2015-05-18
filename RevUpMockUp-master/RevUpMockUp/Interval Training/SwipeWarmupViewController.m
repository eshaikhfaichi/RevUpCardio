//
//  SwipeWarmupViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 13/03/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "SwipeWarmupViewController.h"
#import "SharedManager.h"
#import "UIColor+ColorWithHexString.h"
#import "NotesViewcontroller.h"
#import "SkipWarmUpViewController.h"

@interface SwipeWarmupViewController () {
    
    __weak IBOutlet UIButton *resumeButton;
    __weak IBOutlet UIButton *endWorkoutButton;
}
- (IBAction)endWorkoutTapped:(id)sender;
- (IBAction)skipWarmupClicked:(id)sender;

@end

@implementation SwipeWarmupViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void) configure {
    self.navigationItem.title = @"RevUp";

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log" style:UIBarButtonItemStylePlain target:self action:@selector(logTapped)];
    
    self.skipWarmUpButton.layer.borderColor=[[UIColor blackColor] CGColor];
    self.skipWarmUpButton.layer.borderWidth= 1.0f;
    resumeButton.layer.borderColor=[[UIColor blackColor] CGColor];
    resumeButton.layer.borderWidth= 1.0f;
    endWorkoutButton.layer.borderColor=[[UIColor blackColor] CGColor];
    endWorkoutButton.layer.borderWidth= 1.0f;
    [self.skipWarmUpButton setBackgroundColor:[UIColor colorWithHexString:@"0x292929"]];
    
    [resumeButton setBackgroundColor:[UIColor colorWithHexString:@"0x292929"]];

    [endWorkoutButton setBackgroundColor:[UIColor colorWithHexString:@"0x292929"]];
    
    if([[SharedManager sharedManager] isFreeformScreen] == YES) {
        [self.skipWarmUpButton setTitle:@"Skip Cool Down" forState:UIControlStateNormal];
    }
    self.navigationItem.hidesBackButton = YES;

}

-(void)logTapped {
    
}
- (IBAction)endWorkoutTapped:(id)sender {
    NotesViewcontroller *notesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NotesViewcontroller"];
    UINavigationController *notesNavigation = [[UINavigationController alloc] initWithRootViewController:notesVC];
    [self presentViewController:notesNavigation animated:YES completion:nil];
}

- (IBAction)skipWarmupClicked:(id)sender {
    SkipWarmUpViewController *skipWarmupVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SkipWarmUpViewController"];
    UINavigationController *skipWarmupNavigation = [[UINavigationController alloc] initWithRootViewController:skipWarmupVC];
    [self presentViewController:skipWarmupNavigation animated:YES completion:nil];
}
@end
