//
//  SSubComView.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-15.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "SSubComView.h"
#import "PicNameMc.h"

@interface SSubComView (){
    NSArray *stars;
    NSInteger *numberOfStars;
}

@end
@implementation SSubComView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)starPressed:(UIButton *)sender {
    numberOfStars = sender.tag;
    for (int i = 0; i<[stars count]; i++) {
        UIButton *btn = [stars objectAtIndex:i];
        if (btn.tag<=sender.tag) {
            [btn setSelected:YES];
        }
        else{
            [btn setSelected:NO];
        }
    }

}
- (IBAction)sendComment:(id)sender {
    [self.delegate sendCommentWith:self.textView.text starNumber:numberOfStars];
    
}


-(void)awakeFromNib{
    [self.ssubBar setImage:[PicNameMc defaultBackgroundImage:@"CgaryB" withWidth:self.ssubBar.frame.size.width withTitle:@"写书评" withColor:[UIColor whiteColor]]];
    [self.send setImage:[PicNameMc grayBg:self.send title:@"发送"] forState:UIControlStateNormal];
    
    
    stars = [[NSArray alloc] initWithObjects:self.star1, self.star2, self.star3, self.star4, self.star5, nil];
    for (int i = 0; i<[stars count]; i++) {
        UIButton *btn = [stars objectAtIndex:i];
        btn.tag = i+1;
        [btn addTarget:self action:@selector(starPressed:) forControlEvents:UIControlEventTouchUpInside];
    }

    
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
