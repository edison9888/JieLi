//
//  WeiBoBar.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-12-21.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import "WeiBoBar.h"
@interface WeiBoBar()
@property UIImage *imageU;
@property UIImage *imageB;
@end
@implementation WeiBoBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
-(void)awakeFromNib{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bePressed)];
    [tap setNumberOfTapsRequired:1];
    tap.delegate = self;
    [self addGestureRecognizer:tap];

    
    
}
-(void)checkSelected{
    NSInteger style = [[NSUserDefaults standardUserDefaults] integerForKey:self.weiBoStyle];
    switch (style) {
        case ShareSelected:
            [self.button setSelected:YES];
            self.isSelected = YES;
            break;
//        case ShareUnSelected:
//            
//            break;
//            
        default:
            break;
    }
    
}

-(void)bePressed{
    switch (self.state) {
        case LogInState:
            [self.delegate logInWithWerboBar:self];
//            self.state = ShareState;
            break;
        case ShareState:
        {
            if (!self.isSelected) {
                [self.button setSelected:YES];
                self.isSelected = YES;
                [[NSUserDefaults standardUserDefaults] setInteger:ShareSelected forKey:self.weiBoStyle];
            }
            else{
                [self.button setSelected:NO];
                self.isSelected = NO;
                [[NSUserDefaults standardUserDefaults] setInteger:ShareUnSelected forKey:self.weiBoStyle];

            }
        }
        default:
            break;
    }
}

-(void)setImage:(UIImage *)image{
    [self.imageView setImage:image];
}
-(void)setImageU:(UIImage *)imageU setImageB:(UIImage *)imageB{
    self.imageU = imageU;
    self.imageB = imageB;
}
-(void)setTextWithLogeIn:(NSString *)textA withShare:(NSString *)textB{
    self.logInString = textA;
    self.shareString = textB;
}
-(void)setState:(int)state{
    switch (state) {
        case LogInState:
            [self.title setText:self.logInString];
            [self.imageView setImage:self.imageU];
            _state = LogInState;

            break;
        case ShareState:
            [self.title setText:self.shareString];
            [self.imageView setImage:self.imageB];
            _state = ShareState;

            break;
        default:
            break;
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
