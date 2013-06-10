//
//  ThemesViewController.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-1.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiyTopBar.h"
@interface ThemesViewController : UIViewController
@property (strong, nonatomic) IBOutlet DiyTopBar *diyTopBar;
@property (retain, nonatomic) IBOutlet UILabel *redLabel;
@property (retain, nonatomic) IBOutlet UILabel *blueLabel;
@property (retain, nonatomic) IBOutlet UILabel *guodongLabel;
@property (retain, nonatomic) IBOutlet UIImageView *backGroundImageView;

@end
