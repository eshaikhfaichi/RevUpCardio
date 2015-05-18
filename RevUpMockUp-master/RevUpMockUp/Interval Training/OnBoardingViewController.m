//
//  OnBoardingViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 20/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//



#import "OnBoardingViewController.h"
#import "BenefitsTableViewController.h"
#import "SharedManager.h"
#import "PlotGallery.h"
#import "PlotItem.h"
#import "UIColor+ColorWithHexString.h"



@interface OnBoardingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *benefitsButton;

-(void)setupView;
@end

@implementation OnBoardingViewController
@synthesize detailItem;
@synthesize hostingView;

#pragma mark - View Lifecycle Methods

-(void) viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void) configure {
    
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    
    [self setupView];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Interval Workout";
}

#pragma mark - IBAction Methods

- (IBAction)benefitsClicked:(id)sender {
    BenefitsTableViewController *benefitsTableVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BenefitsTableViewController"];
    self.navigationItem.title = @"";
    [self.navigationController pushViewController:benefitsTableVC animated:YES];
}

#pragma mark - Plot a graph


-(void)setupView
{
    PlotItem *plotItem = [[PlotGallery sharedPlotGallery] objectInSection:0
                                                                  atIndex:0];
    self.detailItem = plotItem;
    CPTTheme *theme;
    theme = [CPTTheme themeNamed:@"DEFAULT"];
    
    [self.detailItem renderInView:hostingView withTheme:theme animated:YES];
}



@end
