//
//  DetailInfoOfActivityViewController.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-24.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiyTopBar.h"
@interface DetailInfoOfActivityViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *myPhotoScrollView;
@property (strong, nonatomic) IBOutlet UITextView *myTextView;
@property (strong, nonatomic) IBOutlet UILabel *myTitleLabel;

@property (strong, nonatomic) IBOutlet UILabel *myTime;
@property (strong, nonatomic) IBOutlet UILabel *myAdress;
@property (strong, nonatomic) IBOutlet UILabel *mySponsor;


@property (strong, nonatomic) IBOutlet UILabel *myPhotoNumber;
@property (strong, nonatomic) IBOutlet DiyTopBar *myTopBar;


@property (strong, nonatomic) IBOutlet UIButton *myBtn_join;
@property (strong, nonatomic) IBOutlet UIButton *myBtn_share;

@property (strong, nonatomic) IBOutlet UIImageView *myPhotoBg;
@property (strong, nonatomic) IBOutlet UIImageView *myBtn_left;
@property (strong, nonatomic) IBOutlet UIImageView *myBtn_right;


@property (strong, nonatomic) IBOutlet UIImageView *myBgImageView;

@property (assign, nonatomic) int activityId;

@end
