//
//  IntervalRoutineInfoViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 26/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "IntervalRoutineInfoViewController.h"
#import "IntervalWorkoutViewController.h"
#import "SharedManager.h"
#import "UIColor+ColorWithHexString.h"

@interface IntervalRoutineInfoViewController () <UITableViewDataSource, UITableViewDelegate> {
    __weak IBOutlet UIView *radioView;
    BOOL radioButtonOn;
    __weak IBOutlet UIButton *startButton;
    __weak IBOutlet UIView *radioButtonView;
    NSArray *arrayOfTitles;
    NSArray *arrayOfSubTitles;
}
@property (weak, nonatomic) IBOutlet UITableView *routineTableView;

- (IBAction)radioButtonClicked:(id)sender;

- (IBAction)startButtonPressed:(id)sender;

@end

@implementation IntervalRoutineInfoViewController

#pragma mark - View Lifecycle Methods

-(void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void)configure {
    radioButtonOn = false;
    self.navigationItem.title = @"Your Routine";

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager]appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
     arrayOfTitles = [NSArray arrayWithObjects:@"10 min warm-up",@"2 min of difficult work",@"1 min of high intensity work",@"2-3 min of easy work",@"Repeat for upto 7 intervals", nil];
    arrayOfSubTitles = [NSArray arrayWithObjects:@"",@"Like a jog",@"Like a sprint",@"Like a walk",@"", nil];
     self.routineTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - IBAction methods
- (IBAction)radioButtonClicked:(id)sender {
    if(radioButtonOn)
    {
        [sender setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
        radioButtonOn = false;
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateNormal ];
        radioButtonOn = true;
    }
    [[SharedManager sharedManager] setRadioButtonWasSelected:YES];
    
}

- (IBAction)startButtonPressed:(id)sender {
    IntervalWorkoutViewController *intervalWorkoutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"IntervalWorkoutViewController"];
    UINavigationController *intervalWorkoutNavigationVC = [[UINavigationController alloc] initWithRootViewController:intervalWorkoutVC];
    [self presentViewController:intervalWorkoutNavigationVC animated:YES completion:nil];
}

#pragma mark - Tableview DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *intervalRoutineIdentifier = @"RoutineCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:intervalRoutineIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoutineCell"];
    }
    cell.textLabel.text = [arrayOfTitles objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    cell.detailTextLabel.text = [arrayOfSubTitles objectAtIndex:indexPath.row];
    cell.detailTextLabel.textColor = [UIColor whiteColor];

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trialImage.png"]];
    tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"trialImage.png"]];
}

@end
