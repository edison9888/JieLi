//
//  ContentViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-6.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "ContentViewController.h"
#import "EPubViewController.h"
#define kDocument_Folder [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]


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
-(void)readOnLine{
//    NSURL *url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"testPdf1"] withExtension:@"pdf"];
//    
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, 320, 480-44)];
//    [self.view.superview.superview addSubview:webView];
//    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
//    [webView loadRequest:req];
    
//    EPubViewController *epub;
//    [epub loadEpub:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"vhugo" ofType:@"epub"]]];

    NSString *epubUrlString  = self.bookInfo.epub_all;
    NSString *epubName = @"http://www.jielibj.com/download.php?path=images/201305/1368083752379138435.epub";
    HCDownLoad *hcd = [HCDownLoad downLoadWithURL:[NSURL URLWithString:epubName]];
    hcd.delegate = self;
    
//    [HCDownLoad downLoadWithURL:[NSURL URLWithString:epubName] begin:^(void){
//        
//    }doing:^(float p){
//        NSLog(@"p:%f",p);
//        
//    }finish:^(NSData *data) {
//        NSLog(@"%d",[data length]);
//    }fail:nil];
    
    
    
    

}

-(void)HCdownloadDoing:(HCDownLoad *)downLoad progress:(float)progress{
    NSLog(@"p:%f",progress);
}
-(void)HCdownloadFinish:(HCDownLoad *)downLoad withData:(NSData *)data{
    NSString *epubName = @"http://www.jielibj.com/download.php?path=images/201305/1368083752379138435.epub";
  
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager changeCurrentDirectoryPath:[kDocument_Folder stringByExpandingTildeInPath]];
    NSString *path = [kDocument_Folder stringByAppendingPathComponent:@"136.epub"];
    //5、创建数据缓冲区
    NSMutableData  *writer = [[NSMutableData alloc] init];
    //6、将字符串添加到缓冲中
        [writer appendData:data];
        //7、将其他数据添加到缓冲中
        //将缓冲的数据写入到文件中
        [writer writeToFile:path atomically:YES];


        EPubViewController *epubController = [[EPubViewController alloc] initWithNibName:@"EPubView" bundle:nil];
        [self.tabBarController.navigationController pushViewController:epubController animated:YES];

    NSURL *urlA = [NSURL fileURLWithPath:path];
    NSURL *urlB = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"人生百忌2" ofType:@"epub"]];
        [epubController loadEpub:urlA];



}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.contentBgImageView setImage:[PicNameMc imageFromImageName:F_image_woodFrame]];
    [self.contentBgImageView setImage:[UIImage imageNamed:@"F_image_woodFrame@2x.png"]];

}
-(void)loadBookInfo:(BookInfo *)info{
    if ([info.bookBrief length]==0) {
        info.bookBrief = @"此书无简介";
    }

    [self.contentTextView setText:info.bookBrief];
    self.bookInfo = [info retain];
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
