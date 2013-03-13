//
//  ContentViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-6.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "ContentViewController.h"
@interface ContentViewController ()

@end

@implementation ContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.contentBgImageView setImage:[PicNameMc imageFromImageName:F_image_woodFrame]];

}
-(void)loadBookInfo:(BookInfo *)info{
    if ([info.bookBrief length]==0) {
        info.bookBrief = @"此书无简介";
    }

    [self.contentTextView setText:info.bookBrief];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setContentBgImageView:nil];
    [self setContentTextView:nil];
    [super viewDidUnload];
}
@end
