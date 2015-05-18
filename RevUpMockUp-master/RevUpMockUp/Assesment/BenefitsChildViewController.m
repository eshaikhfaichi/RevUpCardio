//
//  BenefitsChildViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 20/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "BenefitsChildViewController.h"

@interface BenefitsChildViewController () {
    
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *contentLabel;
}

@end

@implementation BenefitsChildViewController

#pragma mark - View Lifecycle methods

-(void) viewDidLoad {
    [super viewDidLoad];
    if(self.indexNumber == 1) {
        titleLabel.text = @"Burn more fat";
        contentLabel.text = @"The intense exertion kicks your body's repair cycle into hyper-drive. That means you burn more fat and calories in the 24 hours after an interval workout than you do after a steady-pace run";
    }
    else if(self.indexNumber == 2) {
        titleLabel.text = @"Do it anywhere";
        contentLabel.text = @"You can adapt it to whatever time time and space constraints you have. Running. Biking. Jump rope. They all work great.";
    }
    else if(self.indexNumber == 3) {
        titleLabel.text = @"Heart Health";
        contentLabel.text = @"The short cardio bursts make your heart work harder, which strengthens your entire cardiovascular system.";
        
    }
}

@end
