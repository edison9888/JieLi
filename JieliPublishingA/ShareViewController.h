//
//  ShareViewController.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-6.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicBookViewController.h"
#import "AppDelegate.h"
#import "WeiBoBar.h"

@interface ShareViewController : BasicBookViewController<WeiBoDelegate,SinaWeiboDelegate,SinaWeiboRequestDelegate,SinaWeiboAuthorizeViewDelegate>
@property (strong,nonatomic) SinaWeibo *sinaweibo;

@property (strong, nonatomic) IBOutlet UITextView *textView;
@end
