//
//  OnBoardingViewController.h
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 20/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

@class PlotItem;

#import <UIKit/UIKit.h>

@interface OnBoardingViewController : UIViewController

@property (nonatomic, strong) PlotItem *detailItem;

@property (nonatomic, strong) IBOutlet UIView *hostingView;

@end
