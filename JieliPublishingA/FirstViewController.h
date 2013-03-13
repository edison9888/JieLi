//
//  FirstViewController.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-12.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstNavigationBar.h"
#import "DiyTopBar.h"


@interface FirstViewController : UIViewController
@property (strong, nonatomic) IBOutlet DiyTopBar *myDiyTopBar;

@property (strong, nonatomic) IBOutlet UIScrollView *MyScrollorView;
@property (strong, nonatomic) IBOutlet UIPageControl *MyPageControl;
@property (strong, nonatomic) IBOutlet UIImageView *myWoodBg;
//接力好书
@property (strong, nonatomic) IBOutlet UIButton *firstButton;
@property (strong, nonatomic) IBOutlet UILabel *firstlabel;

//促销优惠
@property (strong, nonatomic) IBOutlet UIButton *secondButton;
//读书活动
@property (strong, nonatomic) IBOutlet UIButton *thridButton;
//身边书店
@property (strong, nonatomic) IBOutlet UIButton *forthButton;
//会员专区
@property (strong, nonatomic) IBOutlet UIButton *fifthButton;
//个性设置
@property (strong, nonatomic) IBOutlet UIButton *sixButton;
@property (strong, nonatomic) IBOutlet FirstNavigationBar *myNavigationBar;

@property (assign,nonatomic) int tagIndex;
@end


