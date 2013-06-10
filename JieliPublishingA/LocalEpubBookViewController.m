//
//  LocalEpubBookViewController.m
//  JieLiShelf
//
//  Created by HuaChen on 13-5-28.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "LocalEpubBookViewController.h"
#import "EPubViewController.h"
#import "PicNameMc.h"
#define kDocument_Folder [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

@interface LocalEpubBookViewController ()

@end

@implementation LocalEpubBookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"书架", @"书架");
        self.tabBarItem.image = [UIImage imageNamed:@"tabBar_4"];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.backGroundImageView setImage:[PicNameMc backGroundImage]];

    [self.topBar setType:DiyTopBarTypeNone];
    [self.topBar.backButton addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];
    self.topBar.myTitle.text = @"本地图书";
    self.bookShelf.headerView.hidden = YES;
    self.bookShelf.footerView.hidden = YES;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.topBar updateThemeColor];
    [self.backGroundImageView setImage:[PicNameMc backGroundImage]];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.ebooks = [NSMutableArray arrayWithContentsOfFile:[kDocument_Folder stringByAppendingPathComponent:@"epubBooksList.plist"]];
    NSLog(@"%@",self.ebooks);
    [self.bookShelf reloadData];
    
}

#pragma mark -
#pragma mark HCBookShelf DataSource
-(int)numberOfItemsForShell:(HCBookShelf *)bookShelf{
    if (self.ebooks) {
       return[self.ebooks count];
    }
    return 0;
}
//@"bookName",@"bookThumb",@"fileUrl"
-(BookView *)bookViewForIndex:(NSInteger)index{
    NSDictionary *dic = [self.ebooks objectAtIndex:index];
    BookView *bv = [[BookView alloc] initWithFrame:CGRectMake(0, 0, ImageViewWith, ImageViewHight+LabelHight) withCoverImageUrl:[dic objectForKey:@"bookThumb"] withLableName:[dic objectForKey:@"bookName"]];

    return bv;
}

#pragma mark -
#pragma mark HCBookShelf delegate
-(void)bookShellk:(HCBookShelf *)bookShelf itemSelectedAtIndex:(NSInteger)index{
    NSLog(@"buttonTouchedAt: %d",index);
    EPubViewController *epubController = [[EPubViewController alloc] initWithNibName:@"EPubView" bundle:nil];
    [self.navigationController pushViewController:epubController animated:YES];
    NSString *urlString = [[self.ebooks objectAtIndex:index] objectForKey:@"fileUrl"];
    NSURL *url = [NSURL URLWithString:urlString];
    [epubController loadEpub:url];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_topBar release];
    [_bookShelf release];
    [_backGroundImageView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTopBar:nil];
    [self setBookShelf:nil];
    [self setBackGroundImageView:nil];
    [super viewDidUnload];
}
@end
