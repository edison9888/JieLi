//
//  SSubComView.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-15.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SSubComViewDelegate <NSObject>

-(void)sendCommentWith:(NSString *)content starNumber:(NSInteger )number;
@end
@interface SSubComView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *ssubBar;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *send;
@property (strong, nonatomic) IBOutlet UIButton *star1;
@property (strong, nonatomic) IBOutlet UIButton *star2;
@property (strong, nonatomic) IBOutlet UIButton *star3;
@property (strong, nonatomic) IBOutlet UIButton *star4;
@property (strong, nonatomic) IBOutlet UIButton *star5;

@property (assign) id<SSubComViewDelegate> delegate;
@end
