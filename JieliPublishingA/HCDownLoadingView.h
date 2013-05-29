//
//  HCDownLoadingView.h
//  JieliPublishingA
//
//  Created by HuaChen on 13-5-20.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCDownLoadingView;
@protocol HCDownLoadingViewDelegate <NSObject>
-(void)HCDownLoadingViewClose:(HCDownLoadingView *)view;
@end

typedef void (^CloseResult)();
@interface HCDownLoadingView : UIView
@property (nonatomic,strong) UIProgressView *proGressView;
@property (nonatomic,strong) id<HCDownLoadingViewDelegate>delegate;
+(id)DownLoadingView;
+(id)DownLoadingViewWithClose:(CloseResult )result;

@end
