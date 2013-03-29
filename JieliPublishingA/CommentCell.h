//
//  CommentCell.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-29.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell{
}
@property (assign,nonatomic)  BOOL isHigher;
;
@property (retain,nonatomic) NSDictionary *cellDic;
@property (retain, nonatomic) IBOutlet UILabel *userName;
@property (retain, nonatomic) IBOutlet UILabel *content;
-(void)loadData:(NSDictionary *)dic;
+(NSMutableArray *)cellsForData:(NSArray *)arrayData;
+(CommentCell *)cellFromCell:(CommentCell*)originCell;

@end
