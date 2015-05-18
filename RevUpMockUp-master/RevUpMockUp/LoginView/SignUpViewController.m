//
//  SignUpViewController.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 08/01/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "SignUpViewController.h"
#import "AfterLoginViewController.h"
#import "UIColor+ColorWithHexString.h"
#import "SharedManager.h"
#import <FacebookSDK/FacebookSDK.h>


@interface SignUpViewController () <UIScrollViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *feetArray;
    NSArray *inchesArray;
    UIPickerView *heightPickerView;
    UIDatePicker *signUpDatePicker;
    __weak IBOutlet UIView *DOBView;
    BOOL keyboardVisible;
    __weak IBOutlet UIView *weightView;
    __weak IBOutlet UIView *heightView;
    __weak IBOutlet UIView *genderView;
    CGPoint offset;
    UITextField *currentlyActiveField;
    UIGestureRecognizer *tapper;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UITextField *firstNameTextField;
    IBOutlet UITextField *lastNameTextField;
    IBOutlet UITextField *emailTextField;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UITextField *confirmPasswordTextField;
    IBOutlet UITextField *weightTextField;
    IBOutlet UITextField *heightFeetTextField;
    IBOutlet UITextField *dateTextField;
    __weak IBOutlet UISegmentedControl *genderSegmentedControl;
    __weak IBOutlet UIButton *signUpButton;
}

- (IBAction)signUpClicked:(id)sender;
- (IBAction)loginWithFacebookClicked:(id)sender;

@end

@implementation SignUpViewController

#pragma mark - View Lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configure];

}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Register for the events
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardWillShow:) name: UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardWillHide:) name: UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
}
-(void)configure {

    feetArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    inchesArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"];
    
    //Initially the keyboard is hidden
    keyboardVisible = NO;
    
    //Set navigation color and title color
    self.navigationItem.title = @"Create An Account";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarColor"]]];
    
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:[[[SharedManager sharedManager] appMainDictionary] valueForKey:@"NavigationBarTitleColor"]]}];
    
    scrollView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    
    //Custom Height Picker
    
    heightPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    heightPickerView.dataSource = self;
    heightPickerView.delegate = self;
    UILabel *feetLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, heightPickerView.frame.size.height / 2 - 15, 75, 30)];
    feetLabel.text = @"ft";
    [heightPickerView addSubview:feetLabel];
    
    UILabel *inchesLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, heightPickerView.frame.size.height / 2 - 15, 75, 30)];
    inchesLabel.text = @"in";
    
    [heightPickerView addSubview:inchesLabel];
    heightFeetTextField.inputView = heightPickerView;
    
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    pickerToolbar.barStyle = UIBarStyleDefault;
    
    [pickerToolbar sizeToFit];
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker)];
    
    doneBtn.tintColor = [UIColor blackColor];
    [barItems addObject:doneBtn];
    
    
    [pickerToolbar setItems:barItems animated:YES];
    
    
    heightFeetTextField.inputAccessoryView = pickerToolbar;

    //Open the datePicker on dateTextField
    signUpDatePicker = [[UIDatePicker alloc] init];
    signUpDatePicker.datePickerMode = UIDatePickerModeDate;
    [signUpDatePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    
    dateTextField.inputView = signUpDatePicker;
    
    dateTextField.inputAccessoryView = pickerToolbar;
    
    [self setProperties:firstNameTextField];
    [self setProperties:lastNameTextField];
    [self setProperties:emailTextField];
    [self setProperties:passwordTextField];
    [self setProperties:confirmPasswordTextField];
    [self setProperties:DOBView];
    [self setProperties:heightView];
    [self setProperties:weightView];
    [self setProperties:genderView];
    
    UIColor *color = [UIColor whiteColor];
    firstNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" FIRST NAME" attributes:@{NSForegroundColorAttributeName: color}];
    
    lastNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" LAST NAME" attributes:@{NSForegroundColorAttributeName: color}];
    
    emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" EMAIL" attributes:@{NSForegroundColorAttributeName: color}];
    
    passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  PASSWORD" attributes:@{NSForegroundColorAttributeName: color}];
    
    confirmPasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" CONFIRM PASSWORD" attributes:@{NSForegroundColorAttributeName: color}];
    
    dateTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"MM/DD/YYYY" attributes:@{NSForegroundColorAttributeName: color}];
    
     heightFeetTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"   ft.    in." attributes:@{NSForegroundColorAttributeName: color}];
        
}

-(void) setProperties : (UIView *)view {
    view.layer.borderColor=[[UIColor whiteColor] CGColor];
    view.layer.borderWidth= 1.0f;
    [view.layer setCornerRadius:4.0f];
    view.layer.masksToBounds = YES;
}


- (void) dismissPicker {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Custom Height Picker Delegate Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
        return [feetArray count];
    
    return [inchesArray count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *columnView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3 - 35, 30)];
    if(component == 0) {
    columnView.textAlignment = NSTextAlignmentLeft;
        columnView.text = [NSString stringWithFormat:@"%@", [feetArray objectAtIndex:row]];

    }else {
        columnView.textAlignment = NSTextAlignmentCenter;
        columnView.text = [NSString stringWithFormat:@"%@", [inchesArray objectAtIndex:row]];

    }
    
    return columnView;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if(component == 0) {
        return 80;
    }
    return 100;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger selectedIndexForFeet = [pickerView selectedRowInComponent:0];
    NSInteger selectedIndexForInches = [pickerView selectedRowInComponent:1];
    
    heightFeetTextField.text = [NSString stringWithFormat:@"%@ ft %@ in", [feetArray objectAtIndex:selectedIndexForFeet],[inchesArray objectAtIndex:selectedIndexForInches]];
}

#pragma mark - Date Changed Action Method
- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    dateTextField.text = strDate;
}

- (void)dismissDate:(UIGestureRecognizer *)gestureRecognizer {
    [dateTextField resignFirstResponder];
}


#pragma mark - Validation Methods

-(BOOL)isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

#pragma mark - IBAction Methods

- (IBAction)signUpClicked:(id)sender {
    //Perform Validations
    
    BOOL validEmail = [self isValidEmail:emailTextField.text];
    if([firstNameTextField.text isEqualToString:@""] || [lastNameTextField.text isEqualToString:@""] || [emailTextField.text isEqualToString:@""] || [passwordTextField.text isEqualToString:@""] || [confirmPasswordTextField.text isEqualToString:@""] || [dateTextField.text isEqualToString:@""] || [heightFeetTextField.text isEqualToString:@""] || [weightTextField.text isEqualToString:@""]) {
        UIAlertView *alertMessage = [[UIAlertView alloc] initWithTitle:@"RevUp" message:@"Please fill all the fields" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertMessage show];
    }
    else if(!validEmail) {
        UIAlertView *alertMessage = [[UIAlertView alloc] initWithTitle:@"RevUp" message:@"Please enter a valid email address." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertMessage show];

    }
    else if(![confirmPasswordTextField.text isEqualToString:passwordTextField.text]) {
        UIAlertView *alertMessage = [[UIAlertView alloc] initWithTitle:@"RevUp" message:@"The value you entered did not match the entered password." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertMessage show];
    }
    else if(passwordTextField.text.length < 6 || confirmPasswordTextField.text.length < 6) {
        UIAlertView *alertMessage = [[UIAlertView alloc] initWithTitle:@"RevUp" message:@"Please enter a password that is atleast 6 characters." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertMessage show];
    }
    else {
        self.firstName = firstNameTextField.text;
        self.lastName = lastNameTextField.text;
        self.emailid = emailTextField.text;
        self.height = heightFeetTextField.text;
        self.weight = weightTextField.text;
        self.dateOfBirth = dateTextField.text;
        if(genderSegmentedControl.selectedSegmentIndex == 0) {
            self.isGenderSelected = NO;
        }
        else {
            self.isGenderSelected = YES;
        }
        [[SharedManager sharedManager] setTransparentViewWasDisplayed:YES];


        AfterLoginViewController *afterLoginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AfterLoginViewController"];
        [self presentViewController:afterLoginVC animated:YES completion:nil];
    }
    
}

- (IBAction)loginWithFacebookClicked:(id)sender {
    // Whenever a person opens the app, check for a cached session
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // This method will be called EACH time the session state changes,
                                          // also for intermediate states and NOT just when the session open
                                          //[self sessionStateChanged:session state:state error:error];
                                      }];
    }
    
    
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"email",@"user_location",@"user_birthday",@"user_hometown"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Retrieve the app delegate
             //                 AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             //  [self sessionStateChanged:session state:state error:error];
             
         }];
    }
    
}

// This method will handle ALL the session state changes in the app
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    if (FBSession.activeSession.isOpen) {
        
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 NSLog(@"User details =%@",user);
                 
                 NSString *firstName = user.first_name;
                 NSString *lastName = user.last_name;
                 NSString *facebookId = user.objectID;
                 NSString *email = [user objectForKey:@"email"];
                 NSString *imageUrl = [[NSString alloc] initWithFormat: @"http://graph.facebook.com/%@/picture?type=large", facebookId];
                 NSLog(@"First Name:%@",firstName);
                 NSLog(@"Last Name:%@",lastName);
                 NSLog(@"Facebook Id:%@",facebookId);
                 NSLog(@"Image Url:%@",imageUrl);
                 
                 NSLog(@"Email:%@",email);
                 
             }
         }];
    }
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        [self userLoggedIn];
        
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [self showMessage:alertText withTitle:alertTitle];
                
                // Here we will handle all other errors with a generic error message.
                // We recommend you check our Handling Errors guide for more information
                // https://developers.facebook.com/docs/ios/errors/
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
}
// During the Facebook login flow, your app passes control to the Facebook iOS app or Facebook in a mobile browser.
// After authentication, your app will be called back with the session information.
// Override application:openURL:sourceApplication:annotation to call the FBsession object that handles the incoming URL
- (void) handleOpenURL:(NSNotification*)notification
{
    NSURL* url = [notification object];
    
    if (![url isKindOfClass:[NSURL class]]) {
        return;
    }
    
    [FBSession.activeSession handleOpenURL:url];
}
// Show the user the logged-out UI
- (void)userLoggedOut
{
    
    
    // Confirm logout message
    [self showMessage:@"You're now logged out" withTitle:@""];
}

// Show the user the logged-in UI
- (void)userLoggedIn
{
    
    // Welcome message
    [self showMessage:@"You're now logged in" withTitle:@"Welcome!"];
    
}

// Show an alert message
- (void)showMessage:(NSString *)text withTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:title
                                message:text
                               delegate:self
                      cancelButtonTitle:@"OK!"
                      otherButtonTitles:nil] show];
}


#pragma mark - Keyboard Handling

-(void) keyboardWillShow: (NSNotification *)notif {
    NSLog(@"Keyboard is visible");
    // If keyboard is visible, return
    if (keyboardVisible) {
        NSLog(@"Keyboard is already visible. Ignore notification.");
        return;
    }
    
    // Get the size of the keyboard.
    NSDictionary* info = [notif userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    // Save the current location so we can restore
    // when keyboard is dismissed
    offset = scrollView.contentOffset;
    
    // Resize the scroll view to make room for the keyboard
    CGRect viewFrame = scrollView.frame;
    viewFrame.size.height -= keyboardSize.height+10;
    scrollView.frame = viewFrame;
    
    CGRect textFieldRect = [currentlyActiveField frame];
    textFieldRect.origin.y += 15;
    [scrollView scrollRectToVisible:textFieldRect animated:YES];
    
    // Keyboard is now visible
    keyboardVisible = YES;
}

-(void) keyboardWillHide: (NSNotification *)notif {
    // Is the keyboard already shown
    if (!keyboardVisible) {
        NSLog(@"Keyboard is already hidden. Ignore notification.");
        return;
    }
    
    // Reset the frame scroll view to its original value
    scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    // Reset the scrollview to previous location
    scrollView.contentOffset = offset;
    
    // Keyboard is no longer visible
    keyboardVisible = NO;
}

#pragma mark - Dismiss keyboard when tapped outside it

-(void)handleSingleTap:(UIGestureRecognizer *)sender {
    [self.view endEditing:YES];
}
#pragma mark - TextField Delegate Methods

-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField {
    currentlyActiveField = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
