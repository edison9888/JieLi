//
//  BasicOperation.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-13.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol BasicOperationDelegate <NSObject>
-(void)finishOperation:(id)result;


@end
@interface BasicOperation : NSOperation
@property (strong) id<BasicOperationDelegate> delegate;
-(id)initWithUrl:(NSString *)url;

@end
