//
//  BenefitsViewController.h
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 20/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BenefitsViewController : UIViewController <UIPageViewControllerDataSource>


@property (strong, nonatomic) UIPageViewController *pageController;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign) BOOL isPageSwiped;

@end
