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

@interface ShareViewController : BasicBookViewController<WeiBoDelegate>

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong,nonatomic) UIImage *sendImage;
-(void)sendWeiBo;
@end
