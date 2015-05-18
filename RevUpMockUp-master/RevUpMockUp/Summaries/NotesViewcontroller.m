//
//  NotesViewcontroller.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 03/03/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "NotesViewcontroller.h"
#import "SharedManager.h"
#import "UIColor+ColorWithHexString.h"
#import "LocationFinderViewController.h"
#import "SummaryViewController.h"

@interface NotesViewcontroller () <UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate>{
    NSArray *arrayOfActivities;
    UIPickerView *activityPickerView;
    UITapGestureRecognizer *tapper;

    __weak IBOutlet UITextView *feedbackTextView;

    __weak IBOutlet UIView *locationView;
    __weak IBOutlet UIButton *activityButton;
    __weak IBOutlet UIButton *doneButton;
    __weak IBOutlet UILabel *activityViewLabel;
    __weak IBOutlet UIButton *locationButton;
    __weak IBOutlet UITextField *activityView;
    __weak IBOutlet UIView *feedBackView;
    __weak IBOutlet UIButton *locationViewButton;
}
@property (weak, nonatomic) IBOutlet UIButton *notesButton;
- (IBAction)notesClicked:(id)sender;
- (IBAction)activityButtonPressed:(id)sender;
- (IBAction)locationButtonPressed:(id)sender;

- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)locationViewPressed:(id)sender;
@end

@implementation NotesViewcontroller


#pragma mark - View Lifecycle methods

-(void) viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void) configure {
    self.navigationItem.title = @"Describe It";

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager]appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    arrayOfActivities = [NSArray arrayWithObjects:@"Hiking",@"Cycling",@"Strength",@"Cardio",@"Swimming",@"Other", nil];
   activityPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 250)];
    activityPickerView.dataSource = self;
    activityPickerView.delegate = self;
   
    activityView.inputView = activityPickerView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoardOnSingleTap)];
    [self.view addGestureRecognizer:tap];
//    [scrollView setContentOffset:CGPointZero animated:YES];
       
    locationViewButton.layer.borderColor = [UIColor blackColor].CGColor;
    locationViewButton.layer.borderWidth = 2.0f;
    
    activityView.layer.borderColor = [UIColor blackColor].CGColor;
    activityView.layer.borderWidth = 2.0f;
    
    feedBackView.layer.borderColor = [UIColor blackColor].CGColor;
    feedBackView.layer.borderWidth = 2.0f;
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    
    activityView.layer.cornerRadius = 5;
    activityView.layer.masksToBounds = YES;
    
    feedBackView.layer.cornerRadius = 5;
    feedBackView.layer.masksToBounds = YES;
    
    locationView.layer.cornerRadius = 5;
    locationView.layer.masksToBounds = YES;
}
#pragma mark - Dismiss keyboard when tapped outside it

-(void)handleSingleTap:(UIGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

-(void)dismissKeyBoardOnSingleTap {
    [feedbackTextView resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Custom Height Picker Delegate Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [arrayOfActivities count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        activityLabel.textAlignment = NSTextAlignmentCenter;
        activityLabel.text = [NSString stringWithFormat:@"%@", [arrayOfActivities objectAtIndex:row]];
    [activityLabel setFont:[UIFont systemFontOfSize:25.0]];

    
    return activityLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    activityViewLabel.text = [NSString stringWithFormat:@"%@", [arrayOfActivities objectAtIndex:row]];
    activityViewLabel.textAlignment = NSTextAlignmentCenter;

}

#pragma mark - TextField Delegate Method

-(void)openLocationPreferences {
    LocationFinderViewController *locationFinderVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationFinderViewController"];
    UINavigationController *locationFinderNavigation = [[UINavigationController alloc] initWithRootViewController:locationFinderVC];
    [self presentViewController:locationFinderNavigation animated:YES completion:nil];
    
}

#pragma mark - IBAction Methods

- (IBAction)notesClicked:(id)sender {
    feedbackTextView.textColor = [UIColor whiteColor];
    NSString *currentTitle = [self.notesButton currentTitle];
    if([currentTitle isEqualToString:@"-"]) {
        [self.notesButton setTitle:@"+" forState:UIControlStateNormal];
        float viewHeight = feedBackView.frame.size.height;
        
        CGRect viewFrame = feedBackView.frame;
        viewFrame.size.height = viewHeight - 80.0; //Give it some padding
        feedBackView.frame = viewFrame;
        feedbackTextView.editable = YES;
        feedbackTextView.userInteractionEnabled = YES;
        float height = feedbackTextView.contentSize.height;
        
        CGRect frame = feedbackTextView.frame;
        frame.size.height = height - 80.0; //Give it some padding
        feedbackTextView.frame = frame;
        feedbackTextView.hidden = YES;

    }
    else {
        [self.notesButton setTitle:@"-" forState:UIControlStateNormal];
        float viewHeight = feedBackView.frame.size.height;
        
        CGRect viewFrame = feedBackView.frame;
        viewFrame.size.height = viewHeight + 80.0; //Give it some padding
        feedBackView.frame = viewFrame;
        feedbackTextView.editable = YES;
        feedbackTextView.userInteractionEnabled = YES;
        float height = feedbackTextView.contentSize.height;
        
        CGRect frame = feedbackTextView.frame;
        frame.size.height = height + 80.0; //Give it some padding
        feedbackTextView.frame = frame;
        
        feedbackTextView.hidden = NO;
        
    }
}

- (IBAction)activityButtonPressed:(id)sender {
    
}

- (IBAction)locationButtonPressed:(id)sender {
   

}


- (IBAction)doneButtonPressed:(id)sender {
    feedbackTextView.editable = NO;
    SummaryViewController *summaryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SummaryViewController"];
    [self.navigationController pushViewController:summaryVC animated:YES];
}

- (IBAction)locationViewPressed:(id)sender {
    [self openLocationPreferences];

}

#pragma mark - Adjust view height according to keyboard height

-(void)textViewDidBeginEditing:(UITextView *)textView {
    [self keyBoardAppeared];
}


-(void)textViewDidEndEditing:(UITextView *)textView {
    [self keyBoardDisappeared];
}


-(void) keyBoardAppeared
{
    CGRect frame = self.view.frame;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = CGRectMake(frame.origin.x, frame.origin.y - 130, frame.size.width, frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(void) keyBoardDisappeared
{
    CGRect frame = self.view.frame;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = CGRectMake(frame.origin.x, frame.origin.y+ 130, frame.size.width, frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                     }];
}



@end
