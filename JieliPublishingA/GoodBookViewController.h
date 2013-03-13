//
//  GoodBookViewController.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-12.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationBar.h"
#import "HCBookShelf.h"
#import "AppDelegate.h"

enum{
    BookShelfType1,
    BookShelfType2,
    BookShelfType3,
    BookShelfType4,
};
@class CategoriesView;
@interface GoodBookViewController : UIViewController<DataBrainGetListDelegate>
{
    
}
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong,nonatomic) NSArray *bookShelfImageList;

@property (strong, nonatomic) IBOutlet HCBookShelf *myBookShelf;
@property (assign, nonatomic) int bookShelfType;
@property (strong, nonatomic) IBOutlet UIButton *topBarButton1;
@property (strong, nonatomic) IBOutlet UIButton *topBarButton2;
@property (strong, nonatomic) IBOutlet UIButton *topBarButton3;
@property (strong, nonatomic) IBOutlet UIButton *topBarButton4;

@property (strong,nonatomic) CategoriesView *categoriesView;

@property (strong,nonatomic) AppDelegate *app;
@property (strong,nonatomic) DataBrain *dataBrain;

@property (assign,nonatomic) BOOL isCategoriesViewOpen;

@end
 