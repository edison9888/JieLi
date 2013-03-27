//
//  BookInfo.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-11-21.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import "BookInfo.h"
#define BookId @"bookId"
#define BookName @"bookName"
#define BookAuthor @"bookAuthor"
#define BookDate @"bookDate"
#define BookPrice @"bookPrice"
#define BookImage @"bookImage"
#define BookThumb @"bookThumb"
#define BookBrief @"bookBrief"
#define BookClickCount @"bookClickCount"

@implementation BookInfo

+(NSArray *)bookInfoWithJSON:(NSArray *)dics{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in dics) {
        BookInfo *bookInfo = [BookInfo bookInfoWithBookId:[[dic objectForKey:@"bookId"] intValue]
                                             withBookName:[dic objectForKey:@"bookName"]
                                           withBookAuthor:[dic objectForKey:@"bookAuthor"]
                                             withBookDate:[dic objectForKey:@"bookDate"]
                                            withBookPrice:[[dic objectForKey:@"bookPrice"] floatValue]
                                            withBookImage:[dic objectForKey:@"bookImage"]
                                            withBookThumb:[dic objectForKey:@"bookThumb"]
                                            withBookBrief:[dic objectForKey:@"bookBrief"]
                                       withBookClickCount:[[dic objectForKey:@"bookClickCount"] intValue]
                              ];
        [array addObject:bookInfo];
    }
    return array;
}

+(id)bookInfoWithBookId:(int )bookId
           withBookName:(NSString *)bookName
         withBookAuthor:(NSString *)bookAuthor
           withBookDate:(NSString *)bookDate
          withBookPrice:(float)bookPrice
          withBookImage:(NSString *)bookImage
          withBookThumb:(NSString *)bookThumb
          withBookBrief:(NSString *)bookBrief
     withBookClickCount:(int)bookClickCount{
    return [[self alloc] initBookInfoWithBookId:bookId withBookName:bookName withBookAuthor:bookAuthor withBookDate:bookDate withBookPrice:bookPrice withBookImage:bookImage withBookThumb:bookThumb withBookBrief:bookBrief withBookClickCount:bookClickCount];
    
}

-(id)initBookInfoWithBookId:(int )bookId
               withBookName:(NSString *)bookName
             withBookAuthor:(NSString *)bookAuthor
               withBookDate:(NSString *)bookDate
              withBookPrice:(float)bookPrice
              withBookImage:(NSString *)bookImage
              withBookThumb:(NSString *)bookThumb
              withBookBrief:(NSString *)bookBrief
         withBookClickCount:(int)bookClickCount{
    if (self = [super init]) {
        self.bookId = bookId;
        self.bookImage = bookImage;
        self.bookName = bookName;
        self.bookAuthor = bookAuthor;
        self.bookDate = bookDate;
        self.bookPrice = bookPrice;
        self.bookThumb = bookThumb;
        self.bookBrief = bookBrief;
        self.bookClickCount = bookClickCount;
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:[NSNumber numberWithInt:self.bookId] forKey:BookId];
    [aCoder encodeObject:self.bookName forKey:BookName];
    [aCoder encodeObject:self.bookAuthor forKey:BookAuthor];
    [aCoder encodeObject:self.bookDate forKey:BookDate];
    [aCoder encodeObject:[NSNumber numberWithFloat:self.bookPrice] forKey:BookPrice];
    [aCoder encodeObject:self.bookImage forKey:BookImage];
    [aCoder encodeObject:self.bookThumb forKey:BookThumb];
    [aCoder encodeObject:self.bookBrief forKey:BookBrief];
    [aCoder encodeObject:[NSNumber numberWithFloat:self.bookClickCount] forKey:BookClickCount];
}

-(id)initWithCoder:(NSCoder*)decoder{
    if (self = [super init]) {
        self.bookId = [[decoder decodeObjectForKey:BookId] integerValue];
        self.bookImage = [decoder decodeObjectForKey:BookImage];
        self.bookName = [decoder decodeObjectForKey:BookName];
        self.bookAuthor = [decoder decodeObjectForKey:BookAuthor];
        self.bookDate = [decoder decodeObjectForKey:BookDate];
        self.bookPrice = [[decoder decodeObjectForKey:BookPrice] floatValue];
        self.bookThumb = [decoder decodeObjectForKey:BookThumb];
        self.bookBrief = [decoder decodeObjectForKey:BookBrief];
        self.bookClickCount = [[decoder decodeObjectForKey:BookBrief] integerValue];
    }
    return self;
}

@end
