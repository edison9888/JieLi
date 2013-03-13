//
//  BookCell.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-12.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookInfo.h"
#import "GetImageOperation.h"
#import "AppDelegate.h"

@interface BookCell : UITableViewCell<GetImageOperationDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *coverImage;
@property (strong, nonatomic) IBOutlet UILabel *bookName;
-(void)loadBook:(BookInfo *)bookInfo;

@end