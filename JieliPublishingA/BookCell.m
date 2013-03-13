//
//  BookCell.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-12.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "BookCell.h"
@implementation BookCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)loadBook:(BookInfo *)bookInfo{
    GetImageOperation *op = [[GetImageOperation alloc] initWithBookInfo:bookInfo];
    op.delegate = self;
    [[AppDelegate shareQueue] addOperation:op];
    
    [self.bookName setText:bookInfo.bookName];
}
-(void)finishGetImage:(UIImage *)image{
    [self.coverImage setImage:image];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
