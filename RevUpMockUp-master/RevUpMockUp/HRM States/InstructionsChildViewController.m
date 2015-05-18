//
//  InstructionsChildViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 05/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "InstructionsChildViewController.h"
#import "WarmUpViewController.h"

@interface InstructionsChildViewController()
{
    IBOutlet UITextView *textInstructionsLabel;
    IBOutlet UIButton *nextButton;
}

-(IBAction)nextButtonPressed;

@end

@implementation InstructionsChildViewController

#pragma mark - View Lifecycle Methods

-(void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.indexNumber == 1) {
        textInstructionsLabel.text = @"The length depends on your walking speed, most people finish in 20-30 minutes.";
        [textInstructionsLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
        [textInstructionsLabel setTextColor:[UIColor whiteColor]];
        [self.view bringSubviewToFront:nextButton];
        
    }
    else {
        [nextButton removeFromSuperview];
    }
    
}

#pragma mark - Button Action Methods

-(IBAction)nextButtonPressed {
    WarmUpViewController *warmUpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WarmUpViewController"];
    self.navigationItem.title = @"";

    [self.navigationController pushViewController:warmUpVC animated:YES];
    
}
@end
