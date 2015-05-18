//
//  FreeFormViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 12/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "FreeFormViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "SharedManager.h"
#import "PlotGallery.h"
#import "PlotItem.h"
#import "SwipeWarmupViewController.h"
#import "CircleView.h"

@interface FreeFormViewController () {
    CircleView *circleView;
    NSTimer *timer;
    int currentSeconds;
    __weak IBOutlet UILabel *readyLabel;
    __weak IBOutlet UIImageView *readyImage;
    __weak IBOutlet UILabel *timeLabel;
    __weak IBOutlet UIView *graphView;
}


-(void)setupView;

- (IBAction)swipeButtonPressed:(id)sender;

@end

@implementation FreeFormViewController
@synthesize detailItem;
-(void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void) configure {
    //Roshani - Read the JSON configurations to apply the UI changes
    
    self.navigationItem.title = @"Free Form Workout";
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    [self.view sendSubviewToBack:timeLabel];
    [self.view sendSubviewToBack:graphView];
    [self setupView];
    [self drawCircle];
    [[SharedManager sharedManager] setIsFreeformScreen:YES];
}

-(void) drawCircle {
   circleView = [[CircleView alloc] initWithFrame:CGRectMake(60, 200, 250, 280)];
    [circleView setTitle:@"Go" forState:UIControlStateNormal];
    
    [circleView addFeatures];
    circleView.frame = CGRectMake(self.view.frame.size.width/2 - circleView.frame.size.width/2, self.view.frame.size.height/2 - circleView.frame.size.height/4, circleView.frame.size.width, circleView.frame.size.height);

    [self.view addSubview:circleView];
    [circleView addTarget:self action:@selector(goButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    currentSeconds = 4;
}

-(void) goButtonPressed {
    [readyImage removeFromSuperview];
    [readyLabel removeFromSuperview];
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
            [timeLabel setHidden:YES];
            [self.view bringSubviewToFront:graphView];
            
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


- (IBAction)swipeButtonPressed:(id)sender {
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
