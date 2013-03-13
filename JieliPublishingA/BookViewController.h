//
//  BookViewController.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-16.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookInfo.h"
#import "ShareBookView.h"
#import "ShareMessageView.h"
#import "BuyBookView.h"

@interface BookViewController : UIViewController<ShareBookViewdelegate>

@property (strong,nonatomic) BookInfo *bookInfo;
@property (strong, nonatomic) IBOutlet UIImageView *myCoverImageview;
@property (strong, nonatomic) IBOutlet UILabel *myBookNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *myAutherNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *myBookTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *myPublishTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *myPublishCompanyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *myBookPriceLabel;
@property (strong, nonatomic) IBOutlet UITextView *myTextView;


@property (strong, nonatomic) IBOutlet UIImageView *myBgImageView;
@property (strong, nonatomic) IBOutlet UIButton *myBtn_share;
@property (strong, nonatomic) IBOutlet UIButton *myBtn_readOnLine;
@property (strong, nonatomic) IBOutlet UIButton *myBtn_evaShare;
@property (strong, nonatomic) IBOutlet UIButton *myBtn_compereBuy;
@property (strong, nonatomic) IBOutlet UIImageView *myImageFrame;

@property (strong, nonatomic) IBOutlet ShareBookView *shareBookView;
@property (strong, nonatomic) IBOutlet ShareMessageView *shareMessageView;
@property (strong, nonatomic) IBOutlet BuyBookView *buyBookView;




@end
