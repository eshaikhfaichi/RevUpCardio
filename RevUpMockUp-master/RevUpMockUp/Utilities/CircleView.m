//
//  CircleView.m
//  RevUpMockUp
//
//  Created by Roshani Mahajan on 04/02/15.
//  Copyright (c) 2015 roshni. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect{
    [self drawCircle];
}

-(void) addFeatures {
    self.alpha = 0.8;
    
    self.titleLabel.numberOfLines=2;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];

}

-(void) drawCircle {
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    
    CGContextAddArc(ctx, center.x, center.y, 100.0, 0, 2*M_PI, 0);
    UIColor *fillColor = [UIColor colorWithRed:0.0 green:119.0 blue:119.0 alpha:1.0];

    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
    CGContextFillPath(ctx);
    CGContextStrokePath(ctx);
}

@end
