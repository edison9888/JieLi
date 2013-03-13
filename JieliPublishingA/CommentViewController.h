//
//  CommentViewController.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-6.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicBookViewController.h"
#import "BookInfo.h"

@interface CommentViewController : BasicBookViewController

@property (strong,nonatomic) BookInfo *bookInfo;

-(void)loadData:(id)result;
@end
