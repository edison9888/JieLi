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
#import "SubComView.h"

#define ISLOGED [AppDelegate dAccountName]?1:0
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
-(void)iWantComment{
    SubComView *sc = [[SubComView alloc] init];
    [sc show];
    
    
    
    /*
    UIActionSheet *actionSheet;
    NSString *title;
    NSString *message;
    int tag ;
    if (ISLOGED) {
        tag = 1;
        title = [NSString stringWithFormat:@"您已登录:%@",[AppDelegate dAccountName]];
        message = @"匿名评价";
    }
    else {
        tag = 2;
        title = @"您尚未登录";
        message = @"登录评价";
    }
    actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"返回" destructiveButtonTitle:message otherButtonTitles: nil];
    actionSheet.tag = tag;
    [actionSheet showInView:self.view.superview.superview];
    */
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%d",buttonIndex);
    if (buttonIndex == 0) {
        if (!ISLOGED) {
            LogViewController *viewController = [[LogViewController alloc] initWithNibName:@"LogViewController" bundle:nil];
            viewController.finishToPop = YES;
            [self.delegate pushTo:viewController];

        }
    }
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
