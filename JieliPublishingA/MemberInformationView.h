//
//  MemberInformationView.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-2-1.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBrain.h"
@interface MemberInformationView : UIView
@property (strong,nonatomic) UIViewController *partentViewController;
//展现信息
@property (strong, nonatomic) IBOutlet UILabel *memberName;
@property (strong, nonatomic) IBOutlet UIImageView *memberPhoto;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UIButton *changPassWordButton;
@property (strong, nonatomic) IBOutlet UILabel *nikName;
@property (strong, nonatomic) IBOutlet UILabel *sex;
@property (strong, nonatomic) IBOutlet UILabel *bornDay;
@property (strong, nonatomic) IBOutlet UILabel *mail;
@property (strong, nonatomic) IBOutlet UILabel *profession;

@property (strong, nonatomic) IBOutlet UIButton *disLogButton;


//编辑信息
@property (strong, nonatomic) IBOutlet UIView *editView;

@property (strong, nonatomic) IBOutlet UIImageView *memeberPhotoEdit;
@property (strong, nonatomic) IBOutlet UILabel *memberNameEdit;
@property (strong, nonatomic) IBOutlet UITextField *nikNameEdit;
@property (strong, nonatomic) IBOutlet UITextField *borthDayEdit;
@property (strong, nonatomic) IBOutlet UITextField *mailEdit;
@property (strong, nonatomic) IBOutlet UITextField *professionEdit;
@property (strong, nonatomic) IBOutlet UIDatePicker *birthdayPicker;

@property (strong, nonatomic) IBOutlet UIButton *birthdaySureButton;
@property (strong, nonatomic) IBOutlet UIButton *editEnd;
//修改密码
@property (strong, nonatomic) IBOutlet UITextField *oldPassWord;
@property (strong, nonatomic) IBOutlet UITextField *aNewPassWord;
@property (strong, nonatomic) IBOutlet UITextField *againNewPassWord;
@property (strong, nonatomic) IBOutlet UIButton *postInfo;


-(void)showInformationWith:(NSDictionary *)dic;

@end
