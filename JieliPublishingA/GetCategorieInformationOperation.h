//
//  GetCategorieInformationOperation.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-30.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol GetCategorieInformationOperationDelegate <NSObject>

-(void)getCategorieInformationFinish:(NSDictionary *)dic;

@end
@interface GetCategorieInformationOperation : NSOperation
@property (nonatomic,strong) id<GetCategorieInformationOperationDelegate> delegate;

@end
