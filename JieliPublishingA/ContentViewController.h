//
//  ContentViewController.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-6.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicBookViewController.h"
@interface ContentViewController : BasicBookViewController
@property (strong, nonatomic) IBOutlet UIImageView *contentBgImageView;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
-(void)readOnLine;
@end
