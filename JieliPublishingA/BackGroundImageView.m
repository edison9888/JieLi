//
//  BackGroundImageView.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-7.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "BackGroundImageView.h"
#import "PicNameMc.h"
@implementation BackGroundImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setImage:[PicNameMc backGroundImage]];

    }
    return self;
}

-(void)awakeFromNib{
    [self setImage:[PicNameMc backGroundImage]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
