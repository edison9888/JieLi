//
//  PersonalitySettingViewController.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-24.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DiyTopBar.h"
#import "ThemesViewController.h"
@interface PersonalitySettingViewController : UIViewController
@property (strong, nonatomic) IBOutlet DiyTopBar *myTopBar;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) IBOutlet UIImageView *myBgImageView;


@end
  