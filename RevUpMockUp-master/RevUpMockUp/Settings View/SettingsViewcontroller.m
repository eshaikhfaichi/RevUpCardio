//
//  SettingsViewcontroller.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 12/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "SettingsViewcontroller.h"
#import "SharedManager.h"
#import "TutorialsViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "ProfileViewController.h"
#import "AppSettingsViewController.h"
#import "TutorialsViewController.h"

@interface SettingsViewcontroller () <UITableViewDelegate, UITableViewDataSource>
 {
    NSArray *arrayOfTitles;

}

@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;

@end

@implementation SettingsViewcontroller

#pragma mark - View Lifecycle Methods

-(void) viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void) configure {
    self.navigationItem.title = @"Settings";
    self.navigationItem.backBarButtonItem = nil;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager]appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"DONE" style:UIBarButtonItemStyleDone target:self action:@selector(donePressed)];

    arrayOfTitles = [NSArray arrayWithObjects:@"PROFILE SETTINGS",@"APP PREFERENCES",@"TUTORIALS",@"CONTACT US",@"PRIVACY POLICY", nil];
    self.settingsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - Tableview DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *settingsIdentifier = @"SettingsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingsIdentifier];
    
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingsCell"];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        ProfileViewController *profileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
        [self.navigationController pushViewController:profileVC animated:YES];
    } else if(indexPath.row == 1) {
        AppSettingsViewController *appSettingsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AppSettingsViewController"];
        [self.navigationController pushViewController:appSettingsVC animated:YES];
        
    } else if (indexPath.row == 2) {
        TutorialsViewController *tutorialsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialsViewController"];
        [self.navigationController pushViewController:tutorialsVC animated:YES];
        
    } else if(indexPath.row == 3) {
        
    } else {
        
    }
}

-(void) donePressed {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
