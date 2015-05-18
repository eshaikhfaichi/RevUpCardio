//
//  PastMonthWorkoutViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 22/04/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "PastMonthWorkoutViewController.h"
#import "PastYearWorkoutViewController.h"
#import "SharedManager.h"
#import "InitialDashboardViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "SACalendar.h"
#import "DateUtil.h"


@interface PastMonthWorkoutViewController () <SACalendarDelegate> {
    SACalendar *calendar;
}

@end

@implementation PastMonthWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
    // Do any additional setup after loading the view.
}
-(void) configure {
    //Roshani - Read the JSON configurations to apply the UI changes
    self.navigationItem.title = @"Past Workouts";

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"<Year" style:UIBarButtonItemStyleDone target:self action:@selector(yearPressed)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"homeTitle.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homePressed)];
    
    [rightBarButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    /*
     * Smooth scrolling in vertical direction
     * - to change to horizontal, change the scrollDirection to ScrollDirectionHorizontal
     * - to use paging scrolling, change pagingEnabled to YES
     * - to change the looks, please see documentation on Github
     * - the calendar works with any size
     */
    calendar = [[SACalendar alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-20)
                                            scrollDirection:ScrollDirectionHorizontal
                                              pagingEnabled:NO];
    calendar.delegate = self;
    
    [self.view addSubview:calendar];
    
//    NSLayoutConstraint *calendarTopConstraint = [NSLayoutConstraint
//                                                 constraintWithItem:calendar attribute:NSLayoutAttributeTop
//                                                 relatedBy:NSLayoutRelationEqual toItem:self.view
//                                                 attribute:NSLayoutAttributeTop multiplier:1.0 constant:60.0f];
//    NSLayoutConstraint *calendarBottomConstraint = [NSLayoutConstraint
//                                                    constraintWithItem:calendar attribute:NSLayoutAttributeBottom
//                                                    relatedBy:NSLayoutRelationEqual toItem:self.view
//                                                    attribute:NSLayoutAttributeBottom multiplier:1.0 constant:60.0f];
//    NSLayoutConstraint *calendarLeftConstraint = [NSLayoutConstraint
//                                                  constraintWithItem:calendar attribute:NSLayoutAttributeLeading
//                                                  relatedBy:NSLayoutRelationEqual toItem:self.view attribute:
//                                                  NSLayoutAttributeLeading multiplier:1.0 constant:30.0f];
//    NSLayoutConstraint *calendarRightConstraint = [NSLayoutConstraint
//                                                   constraintWithItem:calendar attribute:NSLayoutAttributeTrailing
//                                                   relatedBy:NSLayoutRelationEqual toItem:self.view attribute:
//                                                   NSLayoutAttributeTrailing multiplier:1.0 constant:-30.0f];
//    [self.view addConstraints:@[calendarBottomConstraint ,
//                                calendarLeftConstraint, calendarRightConstraint,
//                                calendarTopConstraint]];

}

-(void) yearPressed {
    PastYearWorkoutViewController *pastYearVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PastYearWorkoutViewController"];
    [self.navigationController pushViewController:pastYearVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Delegate method : get called when a date is selected
 */
-(void) SACalendar:(SACalendar*)calendar didSelectDate:(int)day month:(int)month year:(int)year
{
    //NSLog(@"Date Selected : %02i/%02i/%04i",day,month,year);
}

/**
 *  Delegate method : get called user has scroll to a new month
 */
-(void) SACalendar:(SACalendar *)calendar didDisplayCalendarForMonth:(int)month year:(int)year{
    //NSLog(@"Displaying : %@ %04i",[DateUtil getMonthString:month],year);
}

- (void)homePressed {
    InitialDashboardViewController *initialDashBoardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InitialDashboardViewController"];
    [self.navigationController pushViewController:initialDashBoardVC animated:YES];
    
}

@end
