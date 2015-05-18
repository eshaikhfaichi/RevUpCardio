//
//  BenefitsViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 20/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "BenefitsViewController.h"
#import "BenefitsTableViewController.h"
#import "SharedManager.h"
#import "BenefitsChildViewController.h"
#import "UIColor+ColorWithHexString.h"

@implementation BenefitsViewController


#pragma mark - View Lifecycle Methods

-(void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void) configure {
    self.isPageSwiped = NO;
    self.navigationItem.title = @"Benefits";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(closePressed)];
   // self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager]appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];

    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    BenefitsChildViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}

#pragma mark - PageviewController DataSource and Delegate Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    self.isPageSwiped = YES;

    NSUInteger index = [(BenefitsChildViewController *)viewController indexNumber];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    self.isPageSwiped = YES;

    NSUInteger index = [(BenefitsChildViewController *)viewController indexNumber];
    index++;
    
    if (index == 4) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}
- (BenefitsChildViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    BenefitsChildViewController *childViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BenefitsChildViewController"];
    if(self.isPageSwiped) {
        childViewController.indexNumber = index;
    }
    else {
        childViewController.indexNumber = self.selectedIndex;
    }
    
    return childViewController;
    
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 4;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    if(self.isPageSwiped) {
        return 0;
    } else {
        return self.selectedIndex;
    }
    return 0;

}
#pragma mark - Button Action Methods

-(void)closePressed {
    BenefitsTableViewController *benefitsTableViewVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BenefitsTableViewController"];
   UINavigationController *benefitsTableNavigationVC =  [[UINavigationController alloc] initWithRootViewController:benefitsTableViewVC];
    [self presentViewController:benefitsTableNavigationVC animated:YES completion:nil];
}

@end
