//
//  IntervalWorkoutViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 12/03/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "IntervalWorkoutViewController.h"
#import "SwipeWarmupViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "SharedManager.h"
#import "CircleView.h"
#import "PlotGallery.h"
#import "PlotGallery.h"
#import "InitialIntervalViewController.h"


@interface IntervalWorkoutViewController() {
    NSTimer *timer;
    int currentSeconds;
    CircleView *circleView;
    __weak IBOutlet UILabel *timeLabel;
    __weak IBOutlet UIView *graphView;
}

-(void)setupView;

- (IBAction)swipebuttonPressed:(id)sender;
@end
@implementation IntervalWorkoutViewController

@synthesize detailItem;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void) configure {
    
    self.navigationItem.title = @"Interval Workout";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    [self.view sendSubviewToBack:timeLabel];
    [self.view sendSubviewToBack:graphView];
    [self setupView];
    [self drawCircle];
    
}

-(void) drawCircle {
     circleView = [[CircleView alloc] initWithFrame:CGRectMake(60, 200, 250, 280)];
    [circleView setTitle:@"Go" forState:UIControlStateNormal];
    
    circleView.frame = CGRectMake(self.view.frame.size.width/2 - circleView.frame.size.width/2, self.view.frame.size.height/2 - circleView.frame.size.height/4, circleView.frame.size.width, circleView.frame.size.height);
    [self.view addSubview:circleView];
    [circleView addFeatures];
    [circleView addTarget:self action:@selector(goPressed) forControlEvents:UIControlEventTouchUpInside];
    currentSeconds = 4;
    circleView.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void) goPressed {
    [circleView removeFromSuperview];
    [self.view bringSubviewToFront:timeLabel];
    [self startTimer];
}

-(void)startTimer {
    timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

-(void)timerFired {
    if(currentSeconds >= 0)
    {
        if(currentSeconds==0)
        {
            [self.view sendSubviewToBack:timeLabel];
            [self.view bringSubviewToFront:graphView];
            [self performSelector:@selector(showInitialInterval) withObject:self afterDelay:10.0f];
            currentSeconds = -1;
        }
        else if(currentSeconds > 0)
        {
            currentSeconds -= 1;
        }
        if(currentSeconds> -1)
            [timeLabel setText:[NSString stringWithFormat:@"%d",currentSeconds]];
    }
    else
    {
        [timer invalidate];
    }
}

-(void) showInitialInterval {
    InitialIntervalViewController *initialIntervalVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InitialIntervalViewController"];
    [self.navigationController pushViewController:initialIntervalVC animated:YES];
}

- (IBAction)swipebuttonPressed:(id)sender {
    SwipeWarmupViewController *swipeWarmUpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SwipeWarmupViewController"];
    [self.navigationController pushViewController:swipeWarmUpVC animated:YES];

}

#pragma mark - Plot a graph


-(void)setupView
{
    PlotItem *plotItem = [[PlotGallery sharedPlotGallery] objectInSection:0
                                                                  atIndex:0];
    self.detailItem = plotItem;
    CPTTheme *theme;
    theme = [CPTTheme themeNamed:@"DEFAULT"];
    
    [self.detailItem renderInView:graphView withTheme:theme animated:YES];
}
@end
