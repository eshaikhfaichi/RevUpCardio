//
//  IntervalWorkoutViewController.h
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 12/03/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

@class PlotItem;
#import <UIKit/UIKit.h>

@interface IntervalWorkoutViewController : UIViewController


@property (nonatomic, strong) PlotItem *detailItem;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@end
