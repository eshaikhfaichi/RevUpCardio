//
//  WalkingAssesmentViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 20/04/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "WalkingAssesmentViewController.h"
#import "SharedManager.h"
#import "SwipeWarmupViewController.h"
#import "UIColor+ColorWithHexString.h"

@interface WalkingAssesmentViewController () {
    NSTimer *timer;
    int currentSeconds;
}
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)swipeButtonPressed:(id)sender;

@end

@implementation WalkingAssesmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
    // Do any additional setup after loading the view.
}

-(void) configure {
    self.navigationItem.title = @"Walking Assessment";
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager]appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    currentSeconds = 4;
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
            [self.timeLabel setText:@"0.50"];
            currentSeconds = -1;

        }
        else if(currentSeconds > 0)
        {
            currentSeconds -= 1;
        }
        if(currentSeconds> -1)
            [self.timeLabel setText:[NSString stringWithFormat:@"%d",currentSeconds]];
    }
    else
    {
        [timer invalidate];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)swipeButtonPressed:(id)sender {
    SwipeWarmupViewController *swipeWarmUpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SwipeWarmupViewController"];
    [self.navigationController pushViewController:swipeWarmUpVC animated:YES];

}
@end
