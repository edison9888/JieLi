//
//  FirstNavigationBar.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-31.
//  Copyright (c) 2012年 中卡. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "FirstNavigationBar.h"

@implementation FirstNavigationBar

- (void)awakeFromNib {
    [super awakeFromNib];
    _image = [UIImage imageNamed:@"topBarBg"];
    _image2 = [UIImage imageNamed:@"firstLogo"];
    //    self.tintColor = [UIColor colorWithRed:46.0 / 255.0 green:149.0 / 255.0 blue:206.0 / 255.0 alpha:1.0];
    
    // draw shadow
//    self.layer.masksToBounds = NO;
//    self.layer.shadowOffset = CGSizeMake(0, 3);
//    self.layer.shadowOpacity = 0.6;
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

- (void)drawRect:(CGRect)rect
{
    [_image drawInRect:rect];
    [_image2 drawInRect:rect];
}

@end
