//
//  CategoriesView.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-11-24.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DataBrain.h"
#import "GoodBookViewController.h"
@interface CategoriesView : UIScrollView<DataBrainGetListDelegate,HCBookShelfDelegate>
@property (nonatomic,strong) DataBrain *dataBrain;
@property (nonatomic,strong)  GoodBookViewController *goodBook;
@property (nonatomic,assign) int currentButtonTag;
@end
