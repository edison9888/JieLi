//
//  LogAndRegister.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-11-2.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LogAndRegisterDelegate <NSObject>
@optional
-(void)logSuccessWithMemberInfo:(NSDictionary *)dic;
-(void)regSuccesshWithMemberInfo:(NSDictionary *)dic;
-(void)cancleBack;

@end

@interface LogAndRegister : UIView<UITextFieldDelegate,UIAlertViewDelegate>{
    CGRect firstFrame;
}
@property (strong, nonatomic) IBOutlet UIView *logView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *registerView;

@property (strong,nonatomic) UIView *bgImageView;

@property (assign,nonatomic) id<LogAndRegisterDelegate> delegate;
@property (strong,nonatomic) UIView *pointToView;

//login
@property (strong, nonatomic) IBOutlet UITextField *userNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *passWordLabel;

@property (strong, nonatomic) IBOutlet UIImageView *myImage_bg;
@property (strong, nonatomic) IBOutlet UIButton *myBtn_cancel;
@property (strong, nonatomic) IBOutlet UIButton *myBtn_logIn;
@property (strong, nonatomic) IBOutlet UIButton *myBtn_reg;


//reg
@property (strong, nonatomic) IBOutlet UITextField *regUserName;
@property (strong, nonatomic) IBOutlet UITextField *regPassWord;

@property (strong, nonatomic) IBOutlet UIImageView *myImage_bg2;
@property (strong, nonatomic) IBOutlet UIButton *myBtn_cancel2;
@property (strong, nonatomic) IBOutlet UIButton *MyBtn_sure;


-(void)close;
-(void)logWithUserName:(NSString *)userName withPassWord:(NSString *)passWord;
-(void)registerWithUserName:(NSString *)userName withPassWord:(NSString *)passWord;


@end
