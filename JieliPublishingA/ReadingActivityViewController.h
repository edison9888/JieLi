//
//  ReadingActivityViewController.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-24.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiyTopBar.h"
#import "AppDelegate.h"
@interface ReadingCard:UIView
@property (strong, nonatomic) IBOutlet UIImageView *myBgImageView;
@property (strong, nonatomic) IBOutlet UIImageView *ThumbImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (assign, nonatomic) int activityId;

@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet UIButton *joinButton;




@end 


@interface ReadingActivityViewController : UIViewController<UIGestureRecognizerDelegate,UIScrollViewDelegate,DataBrainGetListDelegate>
@property (strong, nonatomic) IBOutlet DiyTopBar *myTopBar;


@property (strong, nonatomic) IBOutlet UIImageView *myRootImageView;

@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutlet UIButton *button_onLine;
@property (strong, nonatomic) IBOutlet UIButton *button_offLine;


@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *myPageControl;

@property (strong,nonatomic) DataBrain *dataBrain;






@end