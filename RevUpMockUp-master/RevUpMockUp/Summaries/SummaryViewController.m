//
//  SummaryViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 15/04/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "SummaryViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "SharedManager.h"
#import "SummaryDetailViewController.h"
#import "InitialDashboardViewController.h"
#import "PlotItem.h"
#import "PlotGallery.h"

#define SCROLLVIEW_CONTENT_HEIGHT 800


@interface SummaryViewController () <UIScrollViewDelegate> {
    IBOutlet UILabel *summaryName;
    IBOutlet UILabel *summaryDate;
    IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIButton *doneButton;
    __weak IBOutlet UILabel *pointsEarnedLabel;
    __weak IBOutlet UILabel *vo2Label;
    __weak IBOutlet UILabel *revupAgeLabel;
    __weak IBOutlet UILabel *durationLabel;
    __weak IBOutlet UILabel *distanceLabel;
    __weak IBOutlet UIImageView *maxHeartRateLabel;
    __weak IBOutlet UIView *graphView;
}
- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)revUpLabelClicked:(id)sender;
- (IBAction)vo2LabelClicked:(id)sender;

-(void)setupView;
@end
@implementation SummaryViewController
@synthesize detailItem;
#pragma mark - View Lifecycle Methods

-(void) viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void) configure {
    self.navigationItem.title = @"Summary";
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    scrollView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager]appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, SCROLLVIEW_CONTENT_HEIGHT);
    [self setupView];

}

- (IBAction)doneButtonPressed:(id)sender {
    InitialDashboardViewController *initialDashboardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InitialDashboardViewController"];
    UINavigationController *initialDashboardNavigation = [[UINavigationController alloc] initWithRootViewController:initialDashboardVC];
    initialDashboardVC.initialAssessmentWasCompleted = YES;
    [self presentViewController:initialDashboardNavigation animated:YES completion:nil];
}

- (IBAction)revUpLabelClicked:(id)sender {
    SummaryDetailViewController *summaryDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SummaryDetailViewController"];
    summaryDetailVC.tag = 1;
    [self.navigationController pushViewController:summaryDetailVC animated:YES];
}

- (IBAction)vo2LabelClicked:(id)sender {
    SummaryDetailViewController *summaryDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SummaryDetailViewController"];
    summaryDetailVC.tag = 2;

    [self.navigationController pushViewController:summaryDetailVC animated:YES];
}

#pragma mark - Plot a graph


-(void)setupView
{
    PlotItem *plotItem = [[PlotGallery sharedPlotGallery] objectInSection:0
                                                                  atIndex:0];
    self.detailItem = plotItem;
    CPTTheme *theme;
    theme = [CPTTheme themeNamed:@"DEFAULT"];
    
    [self.detailItem renderInView:graphView withTheme:theme animated:YES];
}


@end
