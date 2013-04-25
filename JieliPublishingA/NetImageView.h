//
//  NetImageView.h
//  aabb
//
//  Created by 花 晨 on 13-4-18.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
//operation委托方法
@protocol ImageOperationDelegate <NSObject>
-(void)ImageOprationFinish:(id)result;

@end
//自定义operation类
@interface ImageOperation : NSOperation{
    NSString *urlString;
}
@property (strong) id<ImageOperationDelegate> delegate;
-(id)initWithUrl:(NSString *)url;
@end



//自定义uiimageview
@interface NetImageView : UIImageView<ImageOperationDelegate>
+(id)NetImageViewWithUrl:(NSString*)url;

@end
