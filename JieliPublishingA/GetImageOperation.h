//
//  GetImageOperation.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-12.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookInfo.h"
@protocol GetImageOperationDelegate <NSObject>
-(void)finishGetImage:(UIImage *)image;


@end
@interface GetImageOperation : NSOperation
@property (strong) id<GetImageOperationDelegate> delegate;
-(id)initWithBookInfo:(BookInfo *)bookInfo;

@end
