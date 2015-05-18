//
//  SummaryDetailViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 15/04/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "SummaryDetailViewController.h"
#import "SummaryViewController.h"
#import "SharedManager.h"
#import "UIColor+ColorWithHexString.h"

@interface SummaryDetailViewController () {
    
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *detailLabel;
}

@end

@implementation SummaryDetailViewController


#pragma mark - View Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

- (void) configure {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(closePressed)];

    if(self.tag == 2) {
        self.navigationItem.title = @"VO2";
        [titleLabel setText:@"VO2"];
        [detailLabel setText:@"The amount of oxygen your lungs take from the air you breathe. A high VO2 score is an indicator of good heart and lung health"];
    }
    else if(self.tag == 1) {
        self.navigationItem.title = @"RevUp Age";

    }
    [self.navigationItem setHidesBackButton:YES];
    

    
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager]appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
}

-(void) closePressed {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
