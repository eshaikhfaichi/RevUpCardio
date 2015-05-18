//
//  TutorialsViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 12/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "TutorialsViewController.h"

@interface TutorialsViewController () {
    NSArray *arrayOfTitles;
    __weak IBOutlet UITableView *tutorialTableView;
}

@end

@implementation TutorialsViewController

#pragma mark - View Lifecycle Methods

-(void) viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Tutorials";
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    arrayOfTitles = [NSArray arrayWithObjects:@"PRODUCT TOUR",@"WHAT ARE ASSESSMENTS?",@"WHAT IS VO2?",@"WHAT IS REVUP AGE?",@"ASSESSMENT INSTRUCTIONS", nil];
    tutorialTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"DONE" style:UIBarButtonItemStyleDone target:self action:@selector(donePressed)];

}

#pragma mark - Tableview DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *settingsIdentifier = @"TutorialsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingsIdentifier];
    
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TutorialsCell"];
    }
        cell.textLabel.text = [arrayOfTitles objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"trialImage.png"]];
    tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"trialImage.png"]];

}
-(void) donePressed {
    
}
@end
