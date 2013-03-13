//
//  DataBrain.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-11-22.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCBookShelf.h"
#import "BookInfo.h"

#define BaseURL @"http://www.jielibj.com/ws/webs.php"
#define GetNumber 6

#define BookCoverImage @"bookCoverImage"
#define PromotionImage @"promotionImage"
#define ActivityImage @"activityImage"
#define ActivityCardImage @"activityCardImage"
enum{
    DownListTypeOfNewBook,
    DownListTypeOfMarketable,
    DownListTypeOfCompetitive,
    DownListTypeOfCategories,
    
    DownListTypeOfCategorieList,
    DownListTypeOfSearch,
    
    DownListTypeOfPromotionList,
    DownListTypeOfActiviey,
    
    DownListTypeOfCraw,
};

@protocol DataBrainGetListDelegate <NSObject>
-(void)finishGetListWithArray:(NSArray *)bookList withType:(int)type;

@end

@interface DataBrain : NSObject{
    id <DataBrainGetListDelegate> getListDelegate;
}
@property (assign,nonatomic) id <DataBrainGetListDelegate> getListDelegate;
@property (strong, nonatomic) NSArray *newBookArray;
@property (strong,nonatomic) NSArray *marketableArray;
@property (strong,nonatomic) NSArray *competitiveArray;

@property (strong,nonatomic) NSArray *categoriesArray;
@property (strong,nonatomic) NSArray *categorieListArray;

@property (strong,nonatomic) NSArray *searchArray;

@property (strong,nonatomic) NSArray *promotionList;

@property (strong,nonatomic) NSArray *ActivityList;

//@property (strong)
-(void)getMoreNewBookList;
-(void)getMarketableBookList;
-(void)getCompetitiveBookList;
-(void)getBookCategories;
-(void)getCategorieList:(int)categoryid;
-(void)getSearchBookList:(NSString *)key;
-(void)getPromotionList;
-(void)getActivityList;
-(void)getCrawlList:(int)bookId;

+(void)writeFile:(NSData*)file withIndex:(int)dataIndex  withFlolderName:(NSString *)myFloderName;
+(NSData *)readFilewithImageId:(int)imageId  withFlolderName:(NSString *)myFloderName;

@end
