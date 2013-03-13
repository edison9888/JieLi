//
//  PromotionViewController.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-16.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiyTopBar.h"
#import "AppDelegate.h"

@interface PersonalitySubView : UIView
@property (strong, nonatomic) IBOutlet UIButton *myActLink;
@property (strong, nonatomic) IBOutlet UIImageView *myimageBar;

@property (strong, nonatomic) IBOutlet UIImageView *myImageView;

@property (strong, nonatomic) IBOutlet UILabel *myTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *resumeLamel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) NSString *myLink;


@end

@interface PromotionViewController : UIViewController<DataBrainGetListDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *myBgImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollerView;
@property (strong, nonatomic) IBOutlet DiyTopBar *myTopBar;

@property (strong,nonatomic) DataBrain *dataBrain;
@property (strong,nonatomic) UIAlertView *alertView;
@end
