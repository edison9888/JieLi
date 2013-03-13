//
//  ShareBookView.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-1-10.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookInfo.h"
#import "AppDelegate.h"
#import "WeiBoBar.h"


@protocol ShareBookViewdelegate <NSObject>

-(void)pushMessageView;


-(NSString *)sendWeiBoWithString;
-(UIImage *)sendWieBoWithImage;

@end
@interface ShareBookView : UIView<WeiBoDelegate,SinaWeiboDelegate,SinaWeiboRequestDelegate,SinaWeiboAuthorizeViewDelegate>
@property (strong,nonatomic) SinaWeibo *sinaweibo;
@property (assign,nonatomic) id <ShareBookViewdelegate> delegate;
@property (nonatomic,strong) BookInfo *bookInfo;
@property (nonatomic,assign) BOOL isOut;
@property (strong, nonatomic) IBOutlet UIButton *addComment;
@property (strong, nonatomic) IBOutlet UIButton *sendWeiBo;

-(void)shareBookViewAppear;

@end
