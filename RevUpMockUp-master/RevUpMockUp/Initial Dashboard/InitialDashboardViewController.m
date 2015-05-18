//
//  InitialDashboardViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 04/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "InitialDashboardViewController.h"
#import "CircleView.h"
#import "WorkOutOptionsViewController.h"
#import "PastWeekWorkoutViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "InstructionsViewController.h"
#import "SettingsViewcontroller.h"
#import "SharedManager.h"

@interface InitialDashboardViewController () {
    CircleView *circleView;
    __weak IBOutlet UIView *bottomView;
}

-(void)slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;

-(void)slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;
@property (weak, nonatomic) IBOutlet UIView *transparentView;
@property (weak, nonatomic) IBOutlet UILabel *swipeLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UIButton *gotItButton;
- (IBAction)gotItPressed:(id)sender;

@end

@implementation InitialDashboardViewController

#pragma mark - View Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
    // Do any additional setup after loading the view.
}

-(void)configure {
    
    //Roshani - Read the JSON configurations to apply the UI changes
    
    self.navigationItem.title = @"Dashboard";
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ios7SettingsNavBar.png"] style:UIBarButtonItemStylePlain target:self action:@selector(settingsButtonPressed)];
    settingsButton.tintColor = [UIColor whiteColor];
    [self.navigationItem setRightBarButtonItem:settingsButton animated:YES];
    
    UISwipeGestureRecognizer *swipeRightAction = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    swipeRightAction.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *swipeLeftAction = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    swipeLeftAction.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:swipeLeftAction];
    
    [self.view addGestureRecognizer:swipeRightAction];
    [self.navigationItem setHidesBackButton:YES];
    
    if([[SharedManager sharedManager] transparentViewWasDisplayed]) {
        self.transparentView.hidden = NO;
        [[SharedManager sharedManager] setTransparentViewWasDisplayed:NO];

    } else {
        [self.transparentView removeFromSuperview];
        self.topLabel.hidden = NO;
        [self drawCircle];


    }
    [self.transparentView setBackgroundColor:[[UIColor colorWithRed:51.0 green:51.0 blue:51.0 alpha:1.0] colorWithAlphaComponent:0]];
    self.swipeLeftLabel.alpha = 0;
    
      
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:3.0];
    self.swipeLeftLabel.alpha = 1.0;
    [self.transparentView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
    [UIView commitAnimations];

    if(self.initialAssessmentWasCompleted == YES) {
        self.topLabel.text = @"Welcome Back, Kate";
        [bottomView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"trialImage.png"]]];
        bottomView.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) drawCircle {
     circleView = [[CircleView alloc] initWithFrame:CGRectMake(60, 200, 250, 280)];
    [circleView setTitle:@"Start" forState:UIControlStateNormal];
    if(self.initialAssessmentWasCompleted == YES) {
        [circleView setTitle:@"Pound It" forState:UIControlStateNormal];
 
    }
    [circleView addFeatures];
    circleView.frame = CGRectMake(self.view.frame.size.width/2 - circleView.frame.size.width/2, self.view.frame.size.height/2 - circleView.frame.size.height/2, circleView.frame.size.width, circleView.frame.size.height);
    [self.view addSubview:circleView];
    [circleView addTarget:self action:@selector(startButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - Button Action methods

-(void)startButtonPressed {
    InstructionsViewController *instructionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InstructionsViewController"];
    UINavigationController *instructionsNavigationVC = [[UINavigationController alloc] initWithRootViewController:instructionsVC];
    [self presentViewController:instructionsNavigationVC animated:YES completion:nil];
    
}

-(void)settingsButtonPressed {
    SettingsViewcontroller *settingsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewcontroller"];
    [self.navigationController pushViewController:settingsVC animated:YES];
}

#pragma mark - Swipe Gesture methods

-(void)slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer{
    [UIView animateWithDuration:0.5 animations:^{
        WorkOutOptionsViewController *workOutOptionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WorkOutOptionsViewController"];
        [self.navigationController pushViewController:workOutOptionsVC animated:YES];
        
    }];
}

-(void)slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer{
   
    [UIView animateWithDuration:0.5 animations:^{
      
        PastWeekWorkoutViewController *pastWeekWorkOutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PastWeekWorkoutViewController"];
        [self.navigationController pushViewController:pastWeekWorkOutVC animated:YES];
    }];
}
- (IBAction)gotItPressed:(id)sender {
    [self.transparentView setHidden:YES];
    self.topLabel.hidden = NO;
    [self drawCircle];
}

@end
