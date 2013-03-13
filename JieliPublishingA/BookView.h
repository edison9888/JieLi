//
//  BookView.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-1-29.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookInfo.h"
@class BookView;

@protocol BookViewDelegate <NSObject>
-(void)bookViewBeTouched:(BookView*)bookView;

@end

@interface BookView : UIView<UIGestureRecognizerDelegate,BookViewDelegate>
@property (strong, nonatomic)  UIImageView *imageView;
@property (strong, nonatomic)  UILabel *labelView; 
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong,nonatomic) BookInfo *bookInfo;
@property (assign,nonatomic) id <BookViewDelegate> delegate;

+(id)BookViewWithBookInfo:(BookInfo*)bookInfo withPosition:(CGPoint)position;
+(id)BookViewWithBookInfo:(BookInfo*)bookInfo;
//-(void)addTaget:(id)taget action:(SEL)action;
@end
