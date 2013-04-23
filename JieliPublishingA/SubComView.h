//
//  SubComView.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-14.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSubComView.h"
#import "CommentPoeration.h"
#import "AppDelegate.h"
#import "CommentViewController.h"
@interface SubComView : UIView<SSubComViewDelegate,CommentPoerationDelegate>
@property (nonatomic,strong) CommentViewController *vc;
-(void)show;
-(void)cancel;
- (id)initWithBookId:(NSInteger )bId userId:(NSString *)uId accountName:(NSString *)aName;

@end
