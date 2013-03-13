//
//  BookDetailViewController.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-6.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookInfo.h"

@protocol BookDetailDelegate <NSObject>
-(void)actionPressed:(UIButton *)b;
@end

@interface BookDetailViewController : UIViewController
@property (nonatomic,strong) BookInfo *bookInfo;
@property (strong, nonatomic) IBOutlet UIButton *actionButton;
@property (nonatomic,assign) id<BookDetailDelegate> delegate;
-(void)loadBookInfo:(BookInfo *)info;

@end
