//
//  CellOfBd.h
//  JieliPublishingA
//
//  Created by HuaChen on 13-4-27.
//  Copyright (c) 2013年 中卡. All rights reserved.
//
#import <ShareSDK/ShareSDK.h>
#import <UIKit/UIKit.h>

@interface CellOfBd : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *BdImageView;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UIButton *logOutButton;
-(void)setShareType:(ShareType)type;
-(void)shouQuan;;

@end
