//
//  PastYearWorkoutViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 21/04/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "PastYearWorkoutViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "InitialDashboardViewController.h"
#import "YearTableViewCell.h"
#import "SharedManager.h"

@interface PastYearWorkoutViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *sectionTitles;
    NSArray *numberOfItemsInARow;
}
@end

@implementation PastYearWorkoutViewController

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
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"homeTitle.png"] style:UIBarButtonItemStylePlain target:self action:@selector(homeButtonPressed)];
    
    [rightBarButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    sectionTitles = [NSArray arrayWithObjects:@"2012",@"2013",@"2014", nil];
    numberOfItemsInARow = [NSArray arrayWithObjects:@"7",@"18",@"24", nil];
}


-(void) drawCircle {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) homeButtonPressed {
    InitialDashboardViewController *initialDashBoardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InitialDashboardViewController"];
    [self.navigationController pushViewController:initialDashBoardVC animated:YES];
}

#pragma mark - Tableview DataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int value;
    int reminder;
    if(section == 0) {
        value = [[numberOfItemsInARow objectAtIndex:0] intValue];
    } else if(section ==1) {
        value = [[numberOfItemsInARow objectAtIndex:1] intValue];
        
    } else {
        value = [[numberOfItemsInARow objectAtIndex:2] intValue];
        
    }
    
    reminder = value%7;
    value = value/7;
    
    if(reminder == 0)
        return value;
    else
        return (value+1);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *tableHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    tableHeader.text = [sectionTitles objectAtIndex:section];
    [tableHeader setTextAlignment:NSTextAlignmentCenter];
    [tableHeader setTextColor:[UIColor whiteColor]];
    [tableHeader setFont:[UIFont boldSystemFontOfSize:15.0f]];
    return tableHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *calendarIdentifier = @"CalendarCell";
    
    YearTableViewCell *cell = (YearTableViewCell *)[tableView dequeueReusableCellWithIdentifier:calendarIdentifier];
    
    
    if(cell == nil)
    {
        cell = [[YearTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CalendarCell"];
        
    }
    
    if((((indexPath.row * 7))+7) > [[numberOfItemsInARow objectAtIndex:indexPath.section] intValue])
    {
        int numberOfButtonsToHide = (int)((((indexPath.row * 7)) + 7) - ([[numberOfItemsInARow objectAtIndex:indexPath.section] intValue]));
        if(numberOfButtonsToHide == 6)
        {
            [cell.secondButton setHidden:YES];
            [cell.thirdButton setHidden:YES];
            [cell.fourthButton setHidden:YES];
            [cell.fifthButton setHidden:YES];
            [cell.sixthButton setHidden:YES];
            [cell.seventhButton setHidden:YES];
        }
        else if(numberOfButtonsToHide == 5)
        {
            [cell.thirdButton setHidden:YES];
            [cell.fourthButton setHidden:YES];
            [cell.fifthButton setHidden:YES];
            [cell.sixthButton setHidden:YES];
            [cell.seventhButton setHidden:YES];
        }
        else if(numberOfButtonsToHide == 4)
        {
            [cell.fourthButton setHidden:YES];
            [cell.fifthButton setHidden:YES];
            [cell.sixthButton setHidden:YES];
            [cell.seventhButton setHidden:YES];
        }
        else if(numberOfButtonsToHide == 3)
        {
            [cell.fifthButton setHidden:YES];
            [cell.sixthButton setHidden:YES];
            [cell.seventhButton setHidden:YES];
        }
        else
        {
            [cell.sixthButton setHidden:YES];
            [cell.seventhButton setHidden:YES];
        }
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trialImage.png"]];
    tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"trialImage.png"]];
    
}


@end
