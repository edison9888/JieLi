//
//  BuyBookView.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-1-11.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBrain.h"
#import "BookInfo.h"

@interface BuyBookView : UIView<DataBrainGetListDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) BookInfo *bookInfo;
@property (strong,nonatomic) DataBrain *dataBrain;
@property (assign,nonatomic) BOOL isOut;
@property (strong,nonatomic) NSArray *arrayOfBuyBoooks;


@property (strong,nonatomic) IBOutlet UITableView *tableView;

-(void)loadData;
@end
