//
//  ThirdViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-15.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import "ThirdViewController.h"
#import "BookViewController.h"
#import "PicNameMc.h"
#import "GoodBookViewController.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"收藏", @"收藏");
        self.tabBarItem.image = [UIImage imageNamed:@"tabBar_3"];
        // Custom initialization

    }
    return self;
}

-(void)awakeFromNib{
//    self.myBookShelf = [[HCBookShelf alloc] initWithFrame:CGRectMake(0, 44, 320, 367)];
//    [self.view addSubview:self.myBookShelf];
//    self.myBookShelf.dataSource = self;
//    self.myBookShelf.itemSelectedDelegate = self;
//    self.myBookShelf.showPrice = YES;
//    [self.myBookShelf reloadData];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.myBookShelf.showPrice = NO;
    [self.myBookShelf reloadData];
    
    [self.myDiyTopBar.myTitle setText:@"图书收藏"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMyBookShelf:nil];
    [self setMyDiyTopBar:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark HCBookShelf DataSource
-(int)numberOfItemsForShell:(HCBookShelf *)bookShelf{
    return 11;
}
-(UIImage *)bookShlef:(HCBookShelf *)bookShelf imageForItemAtIndex:(NSInteger)index{
    return nil;
}
-(int)bookShell:(HCBookShelf *)bookShelf priceForItemAtIndex:(NSInteger)index{
    return index;
}
#pragma mark -
#pragma mark HCBookShelf delegate
-(void)bookShellk:(HCBookShelf *)bookShelf itemSelectedAtIndex:(NSInteger)index{
    NSLog(@"buttonTouchedAt: %d",index);
//    //    UINavigationController *navigationController = (UINavigationController *)self.parentViewController;
    BookViewController *viewController = [[BookViewController alloc] initWithNibName:@"BookViewController" bundle:nil];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}
- (IBAction)toJieLiShuFang:(id)sender {
    GoodBookViewController *viewController = [[GoodBookViewController alloc] initWithNibName:@"GoodBookViewController" bundle:nil];
    
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}


@end
