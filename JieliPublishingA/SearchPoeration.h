//
//  SearchPoeration.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-12.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SearchPoerationDelegate <NSObject>
-(void)finishPoeration:(id)result;
@end

@interface SearchPoeration : NSOperation
@property (nonatomic,assign) id<SearchPoerationDelegate> delegate;
-(id)initWithKeyWord:(NSString *)keyWord;

@end