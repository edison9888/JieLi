//
//  BasicOperation.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-13.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol BasicOperationDelegate <NSObject>
@optional
-(void)finishOperation:(id)result;
-(void)finishOperationWithOperation:(id)op result:(id)result;

@end
@interface BasicOperation : NSOperation
@property (strong) id<BasicOperationDelegate> delegate;
@property (assign) int tag;
-(id)initWithUrl:(NSString *)url;
+(id)basicOperationWithUrl:(NSString *)url withTaget:(id)t select:(SEL)s;

@end
