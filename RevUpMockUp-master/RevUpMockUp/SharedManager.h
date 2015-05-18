//
//  SharedManager.h
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 09/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+ColorWithHexString.h"
#import "SignUpViewController.h"

@class SignUpViewController;

@interface SharedManager : NSObject
{
    SignUpViewController *signUpViewController;
}

+(id)sharedManager;
-(void) initalizeDictionary;


- (NSDictionary *) dictionaryFromBundledJSONFile:(NSString *) jsonFileName ;

@property (nonatomic, retain) SignUpViewController *signUpViewController;
@property (nonatomic, retain) NSDictionary *appMainDictionary;
@property (nonatomic, assign) BOOL transparentViewWasDisplayed;
@property (nonatomic, assign) BOOL isFreeformScreen;
@property (nonatomic, assign) BOOL radioButtonWasSelected;
@end
