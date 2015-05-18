//
//  InstructionsViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 05/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "InstructionsViewController.h"
#import "InstructionsChildViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "SharedManager.h"


@interface InstructionsViewController ()

@end
@implementation InstructionsViewController

#pragma mark - View Lifecycle Methods

-(void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}
-(void)configure{
    
    self.navigationItem.title = @"Directions";
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    InstructionsChildViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - PageController DataSource and Delegate methods
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(InstructionsChildViewController *)viewController indexNumber];
    
    if (index == 0) {

        return nil;
    }

    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(InstructionsChildViewController *)viewController indexNumber];
    
    
    index++;
    
    if (index == 2) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}
- (InstructionsChildViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    InstructionsChildViewController *childViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InstructionsChildViewController"];
    childViewController.indexNumber = index;
    if(index == 0) {
        self.navigationItem.title = @"Directions";

    }else if(index == 1) {
    self.navigationItem.title = @"Duration";
    }

    
    return childViewController;
    
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}




@end
