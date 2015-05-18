//
//  CustomButton.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 11/05/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.layer.cornerRadius= 3.0;
    self.clipsToBounds= YES;
}


@end
