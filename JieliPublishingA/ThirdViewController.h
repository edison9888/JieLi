//
//  ThirdViewController.h
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-15.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCBookShelf.h"
#import "DiyTopBar.h"
#import "BookShelfTableViewController.h"
@interface ThirdViewController : UIViewController<HCBookShelfDataSource,HCBookShelfDelegate,BookShelfTableViewControllerDelegate>
@property (strong, nonatomic) IBOutlet HCBookShelf *myBookShelf;
@property (strong, nonatomic) IBOutlet DiyTopBar *myDiyTopBar;
@property (retain, nonatomic) IBOutlet UIImageView *noCollectImageview;
@property (retain, nonatomic) IBOutlet UIButton *noCollectButton;

@end
