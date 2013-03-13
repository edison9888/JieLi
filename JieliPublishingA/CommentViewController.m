//
//  CommentViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-6.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentPoeration.h"
#import "AppDelegate.h"
@interface CommentViewController ()

@end

@implementation CommentViewController

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
    
    
}
-(void)loadBookInfo:(BookInfo *)info{
    self.bookInfo = info;
    CommentPoeration *po = [[CommentPoeration alloc] initWithTaget:self withBookId:self.bookInfo.bookId];
    [[AppDelegate shareQueue] addOperation:po];
    
}
-(void)loadData:(id)result{
    NSLog(@"%@",result);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
