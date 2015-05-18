//
//  PastWeekWorkoutViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 05/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "UIColor+ColorWithHexString.h"
#import "PastWeekWorkoutViewController.h"
#import "InitialDashboardViewController.h"
#import "SummaryViewController.h"
#import "SummaryIntervalsViewController.h"
#import "SummaryFreeFormViewController.h"
#import "PastMonthWorkoutViewController.h"
#import "SharedManager.h"


@interface PastWeekWorkoutViewController () {
    UILabel *workoutCategory;
    UILabel *timeLabel;
    UILabel *dateLabel;
    __weak IBOutlet UIView *topView;
}
-(void)slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;
@property (weak, nonatomic) IBOutlet UITableView *workoutTableView;

@end

@implementation PastWeekWorkoutViewController

#pragma mark - View Lifecycle methods

-(void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
    
}

-(void)configure{
    
    //Roshani - Read the JSON configurations to apply the UI changes
    self.navigationItem.title = @"Past Workouts";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    UISwipeGestureRecognizer *swipeRightAction = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    swipeRightAction.direction = UISwipeGestureRecognizerDirectionRight;
    [self.workoutTableView addGestureRecognizer:swipeRightAction];
    [self.view addGestureRecognizer:swipeRightAction];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"< Month" style:UIBarButtonItemStylePlain target:self action:@selector(monthButtonPressed)];
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"homeTitle.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeButtonPressed)];
    rightBarButton.tintColor = [UIColor whiteColor];

    [leftBarButton setTintColor:[UIColor whiteColor]];

    [rightBarButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    self.workoutTableView.separatorColor = [UIColor darkGrayColor];
    self.workoutTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.workoutTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trialImage.png"]];
}

#pragma mark - Table View Data Source and Delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trialImage.png"]];
}

-(void) changeCells:(NSIndexPath*)path {
    if(path.row == 1 || path.row == 2) {
        workoutCategory.text = @"FreeForm";
        dateLabel.text = @"9/25/2014";
        timeLabel.text = @"02:30:12";
    }
    else if(path.row == 4) {
        workoutCategory.text = @"Assessment";
        dateLabel.text = @"9/22/2014";
        timeLabel.text = @"33.5VO";
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 1 || indexPath.row == 2) {
        SummaryFreeFormViewController *freeformVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SummaryFreeFormViewController"];
        [self.navigationController pushViewController:freeformVC animated:YES];
    }
    else if(indexPath.row == 4) {
        SummaryViewController *assesmentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SummaryViewController"];
        [self.navigationController pushViewController:assesmentVC animated:YES];
    }
    else {
        SummaryIntervalsViewController *intervalsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SummaryIntervalsViewController"];
        [self.navigationController pushViewController:intervalsVC animated:YES];

    }
   
}


#pragma mark - Navigation Bar Button Actions

-(void)monthButtonPressed {
    PastMonthWorkoutViewController *pastMonthWorkoutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PastMonthWorkoutViewController"];
    UINavigationController *pastMonthWorkoutNavigation = [[UINavigationController alloc] initWithRootViewController:pastMonthWorkoutVC];
    [self presentViewController:pastMonthWorkoutNavigation animated:YES completion:nil];
}

-(void)homeButtonPressed {
    InitialDashboardViewController *initialDashBoardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InitialDashboardViewController"];
    [self.navigationController pushViewController:initialDashBoardVC animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"WeekCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    dateLabel = (UILabel *)[cell viewWithTag:1];
    workoutCategory = (UILabel *)[cell viewWithTag:2];
    timeLabel = (UILabel *)[cell viewWithTag:3];
    [self changeCells:indexPath];
   
    return cell;
}

#pragma mark - Swipe Gesture methods

-(void)slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer{
    [UIView animateWithDuration:0.5 animations:^{
        InitialDashboardViewController *initialDashBoardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InitialDashboardViewController"];
        [self.navigationController pushViewController:initialDashBoardVC animated:YES];
        
    }];
}


@end
