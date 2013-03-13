//
//  DiyTopBar.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-11-1.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>

enum{
    DiyTopBarTypeNone,
    DiyTopBarTypeBack,
    DiyTopBarTypeCollect,
    DiyTopBarTypeBackAndCollect,
}DiyTopBarType;

@interface DiyTopBar : UIView
@property(strong,nonatomic) UIImageView *myImageView;
@property(strong,nonatomic) UIButton *myButton;
@property(strong,nonatomic) UILabel *myTitle;
@property(strong,nonatomic) UIImageView *header_left;
@property(strong,nonatomic) UIImageView *header_right;

@property (strong,nonatomic) UIButton *backButton;
@property (strong,nonatomic) UIButton *collectButton;

-(void)setType:(int)type;

@end
