//
//  CellA.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-1-21.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellA : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (assign,nonatomic) int type;
@end
