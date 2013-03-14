//
//  ReadEventOperation.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-14.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ReadEventOperationDelegate <NSObject>

-(void)finishPoeration:(id)result;

@end
@interface ReadEventOperation : NSOperation
@property (assign) id<ReadEventOperationDelegate> delegate;
-(id)initWithEventId:(NSInteger)Id;

@end


