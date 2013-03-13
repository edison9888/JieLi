//
//  ShareMessageView.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-1-11.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareMessageView : UIView<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,assign) BOOL isOut;

@end
