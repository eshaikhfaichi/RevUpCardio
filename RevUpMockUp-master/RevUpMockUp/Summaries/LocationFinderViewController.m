//
//  LocationFinderViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 09/03/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "LocationFinderViewController.h"
#import "SharedManager.h"
#import <MapKit/MapKit.h>
#import "UIColor+ColorWithHexString.h"

@interface LocationFinderViewController () <CLLocationManagerDelegate> {
    
    __weak IBOutlet UITableView *locationTableView;
    __weak IBOutlet UISearchBar *locationSearchbar;
}

@end

@implementation LocationFinderViewController

#pragma mark - View Lifecycle Methods

-(void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}
-(void)configure {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"trialImage.png"]];
    [locationTableView setBackgroundView:imageView];

    self.navigationItem.title = @"Location";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager]appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonPressed)];
   // self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

#pragma mark - TableView Delegate And DataSource Methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"LocationCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - Action Methods

-(void)cancelButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
