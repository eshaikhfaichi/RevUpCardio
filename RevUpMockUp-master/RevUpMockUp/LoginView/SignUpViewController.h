//
//  SignUpViewController.h
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 08/01/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface SignUpViewController : UIViewController

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *emailid;
@property (nonatomic, retain) NSString *dateOfBirth;
@property (nonatomic, retain) NSString *height;
@property (nonatomic, retain) NSString *weight;
@property (nonatomic, assign) BOOL isGenderSelected;

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
@end
