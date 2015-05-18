//
//  InitialIntervalViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 22/04/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "InitialIntervalViewController.h"
#import "NotesViewcontroller.h"
#import "SharedManager.h"
#import "UIColor+ColorWithHexString.h"

@interface InitialIntervalViewController () <UITextFieldDelegate> {
    
    __weak IBOutlet UIButton *continueButton;
    __weak IBOutlet UIView *renameView;
    __weak IBOutlet UITextField *workoutTextfield;

}
- (IBAction)renameButtonClicked:(id)sender;
- (IBAction)continueButtonClicked:(id)sender;

@end

@implementation InitialIntervalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
    // Do any additional setup after loading the view.
}


-(void) configure {
    self.navigationItem.title = @"Workout";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(goBackToController)];
    
    renameView.layer.cornerRadius=3.0;
    renameView.clipsToBounds=YES;
    renameView.layer.borderColor=[[UIColor blackColor] CGColor];
    renameView.layer.borderWidth= 2.0f;
    
    UIColor *placeHolderColor = [UIColor greenColor];
    workoutTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"INTERVAL TRAINING" attributes:@{NSForegroundColorAttributeName: placeHolderColor}];

    
    [renameView setBackgroundColor:[UIColor colorWithHexString:@"0x292929"]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) goBackToController {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)renameButtonClicked:(id)sender {
    workoutTextfield.enabled = YES;
}

- (IBAction)continueButtonClicked:(id)sender {
    NotesViewcontroller *notesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NotesViewcontroller"];
    UINavigationController *notesVCNavigation = [[UINavigationController alloc] initWithRootViewController:notesVC];
    [self presentViewController:notesVCNavigation animated:YES completion:nil];
}


#pragma mark - Adjust view height according to keyboard height

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self keyBoardAppeared];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self keyBoardDisappeared];
    
}

-(void) keyBoardAppeared
{
    CGRect frame = self.view.frame;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.view.frame = CGRectMake(frame.origin.x, frame.origin.y - 150, frame.size.width, frame.size.height);
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
                         self.view.frame = CGRectMake(frame.origin.x, frame.origin.y+ 150, frame.size.width, frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

#pragma mark - UITextviewDelegate Methods

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
