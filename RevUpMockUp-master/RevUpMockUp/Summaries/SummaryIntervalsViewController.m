//
//  SummaryIntervalsViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 21/04/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "SummaryIntervalsViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "SharedManager.h"
#import "InitialDashboardViewController.h"
#import "PlotItem.h"
#import "PlotGallery.h"

#define SCROLLVIEW_CONTENT_HEIGHT 1250

@interface SummaryIntervalsViewController () <UIScrollViewDelegate> {
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIButton *doneButton;

    __weak IBOutlet UIView *graphView;
}
- (IBAction)donePressed:(id)sender;

-(void)setupView;
@end

@implementation SummaryIntervalsViewController
@synthesize detailItem;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
    // Do any additional setup after loading the view.
}

-(void) configure {
    self.navigationItem.title = @"Summary";
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    scrollView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager]appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, SCROLLVIEW_CONTENT_HEIGHT);
    [self setupView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Plot a graph


- (IBAction)donePressed:(id)sender {
    InitialDashboardViewController *initialDashboardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InitialDashboardViewController"];
    UINavigationController *initialDashboardNavigation = [[UINavigationController alloc] initWithRootViewController:initialDashboardVC];
    [self presentViewController:initialDashboardNavigation animated:YES completion:nil];

}

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
