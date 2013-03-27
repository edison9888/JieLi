//
//  CollectbookPoeration.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-27.
//  Copyright (c) 2013年 中卡. All rights reserved.
//


typedef enum {
    CollectTypeOfCollectOne,
    CollectTypeOfDelOne,
    CollectTypeOfGetList
}CollectType;
@protocol CollectbookPoerationDelegate <NSObject>
-(void)finishPoeration:(id)result;

@end
#import <Foundation/Foundation.h>

@interface CollectbookPoeration : NSOperation
@property (nonatomic,strong) id<CollectbookPoerationDelegate> delegate;
@end
