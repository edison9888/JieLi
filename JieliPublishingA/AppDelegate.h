//
//  AppDelegate.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-12.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBrain.h"
#import "SinaWeibo.h"
#import "BMapKit.h"

#define kAppKey             @"1121796814"
#define kAppSecret          @"152a12ee831277740fb7ef7708ca65eb"
#define kAppRedirectURI     @"http://www.apple.com"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,UINavigationControllerDelegate,SinaWeiboDelegate>{
    BMKMapManager *_mapManager;

}
@property (strong, nonatomic) SinaWeibo *sinaweibo;

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong,nonatomic) DataBrain *dataBrain;
+(id)shareQueue;
+(NSString *)dAccountName;
+(void)setdAccountName:(NSString *)v;
+(NSString *)dPassWord;
+(void)setdPassWord:(NSString *)v;
+(NSString *)dUserId;
+(void)setdUserId:(NSString *)v;
+(void)dLogOut;
+(void)dLogInWithUserId:(NSString *)userId accountName:(NSString *)accountName passWord:(NSString *)passWord;
+(void)collectABook:(BookInfo *)bookInfo;
+(NSArray *)getCollectedBooks;
+(BOOL)idCollectedBook:(BookInfo *)bookInfo;

@end
