//
//  BenefitsTableViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 20/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "BenefitsTableViewController.h"
#import "SharedManager.h"
#import "BenefitsViewController.h"
#import "IntervalRoutineInfoViewController.h"
#import "IntervalWorkoutViewController.h"
#import "UIColor+ColorWithHexString.h"

@interface BenefitsTableViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray *benefitsArray;
    __weak IBOutlet UITableView *optionsTableView;
    __weak IBOutlet UIButton *continueButton;
}

- (IBAction)continuePressed:(id)sender;
@end

@implementation BenefitsTableViewController


#pragma mark - View Lifecycle Methods

-(void) viewDidLoad {
    [super viewDidLoad];
    [self configure];
}
-(void) configure {
   
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager]appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    benefitsArray = [NSArray arrayWithObjects:@"Time Efficient",@"Burn more fat",@"Do it anywhere",@"Heart Health", nil];
    optionsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    optionsTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trialImage.png"]];



}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Benefits";
}

#pragma mark - Table View Data Source and Delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 20;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"BenefitsCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        CALayer* layer = cell.layer;
//        [layer setCornerRadius:8.0f];
//        [layer setMasksToBounds:YES];
//        [layer setBorderWidth:2.0f];
//        [layer setBackgroundColor:(__bridge CGColorRef)([UIColor redColor])];
    }
    cell.textLabel.text = [benefitsArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        self.tableIndexNumber = 0;
    }
    else if(indexPath.row == 1) {
        self.tableIndexNumber = 1;
    }
    else if(indexPath.row == 2) {
        self.tableIndexNumber = 2;
    }
    else {
        self.tableIndexNumber = 3;
    }
  
    //[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    BenefitsViewController *benefitsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BenefitsViewController"];
    benefitsVC.selectedIndex = self.tableIndexNumber;
    UINavigationController *benefitsNavigationVC = [[UINavigationController alloc] initWithRootViewController:benefitsVC];
    [self presentViewController:benefitsNavigationVC animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trialImage.png"]];
}

#pragma mark - Button Action Methods

- (IBAction)continuePressed:(id)sender {
    if([[SharedManager sharedManager] radioButtonWasSelected] == YES) {
        IntervalWorkoutViewController *intervalWorkoutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"IntervalWorkoutViewController"];
        UINavigationController *intervalWorkoutNavigationVC = [[UINavigationController alloc] initWithRootViewController:intervalWorkoutVC];
        [self presentViewController:intervalWorkoutNavigationVC animated:YES completion:nil];
        
    } else {
        IntervalRoutineInfoViewController *intervalRoutineInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"IntervalRoutineInfoViewController"];
        self.navigationItem.title = @"";

        [self.navigationController pushViewController:intervalRoutineInfoVC animated:YES];
    }
}


@end
