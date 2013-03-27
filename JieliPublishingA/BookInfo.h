//
//  BookInfo.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-11-21.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookInfo : NSObject<NSCoding>
@property (nonatomic,assign) int bookId;
@property (nonatomic,strong) NSString *bookName;
@property (nonatomic,strong) NSString *bookAuthor;
@property (nonatomic,strong) NSString *bookDate;
@property (nonatomic,assign) float bookPrice;
@property (nonatomic,strong) NSString *bookImage;
@property (nonatomic,strong) NSString *bookThumb;
@property (nonatomic,strong) NSString *bookBrief;
@property (nonatomic,assign) int bookClickCount;

+(id)bookInfoWithBookId:(int )bookId
           withBookName:(NSString *)bookName
         withBookAuthor:(NSString *)bookAuthor
           withBookDate:(NSString *)bookDate
          withBookPrice:(float)bookPrice
          withBookImage:(NSString *)bookImage
          withBookThumb:(NSString *)bookThumb
          withBookBrief:(NSString *)bookBrief
     withBookClickCount:(int)bookClickCount;
+(NSArray *)bookInfoWithJSON:(NSArray *)dics;

@end
