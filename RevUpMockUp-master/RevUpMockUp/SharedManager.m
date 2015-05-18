//
//  SharedManager.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 09/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "SharedManager.h"
#import "InitialDashboardViewController.h"

static SharedManager *sharedManager = nil;


@implementation SharedManager
@synthesize signUpViewController;

+(id)sharedManager {
    if(sharedManager == nil) {
        sharedManager = [[super allocWithZone:NULL] init];
    }
    return sharedManager;
}


-(id)init {
    if(self = [super init]) {
      UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];
        SignUpViewController *controller = (SignUpViewController *)[mainStoryboard
                                                                         instantiateViewControllerWithIdentifier: @"SignUpViewController"];
        self.signUpViewController = controller;
        self.transparentViewWasDisplayed = NO;
        self.isFreeformScreen = NO;
        self.radioButtonWasSelected = NO;
    }
    return self;
}

#pragma mark - Utility methods

- (NSDictionary *) dictionaryFromBundledJSONFile:(NSString *) jsonFileName {
    //Read json config file for MultiJournal view
    NSDictionary *jsonDictionary = nil;
    
    @try {
        NSString *configFileString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:jsonFileName ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
        
        NSError *jsonReadError;
        
        jsonDictionary = [NSJSONSerialization JSONObjectWithData:[configFileString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&jsonReadError];
        if (jsonReadError) {
            NSLog(@"Error getting json data from config file: %@", jsonReadError.localizedDescription);
            jsonDictionary = nil;
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception reading config file: Name: %@\nReason: %@", exception.name, exception.reason);
        jsonDictionary =nil;
    }
    @finally {
    }
    
    return jsonDictionary;
}

-(void) initalizeDictionary {
    self.appMainDictionary = nil;
    self.appMainDictionary = [self dictionaryFromBundledJSONFile:@"AppMain"];
}


@end
