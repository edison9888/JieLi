//
//  BDAccountViewController.m
//  JieliPublishingA
//
//  Created by HuaChen on 13-4-26.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "BDAccountViewController.h"
#import "DiyTopBar.h"
#import "CellOfBd.h"
@interface BDAccountViewController ()

@end

@implementation BDAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        
        
        DiyTopBar *topBar = [[DiyTopBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [topBar setType:DiyTopBarTypeBack];
        topBar.myTitle.text = @"账号绑定";
        [topBar.backButton addTarget:self action:@selector(popback) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:topBar];
        
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.frame.size.height -44) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
    }
    return self;
}
-(void)popback{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--
#pragma mark tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CellOfBd" owner:self options:nil];
    CellOfBd *cell = (CellOfBd *)[nibs objectAtIndex:0];
    switch (indexPath.row) {
        case 0:
            [cell setShareType:ShareTypeSinaWeibo];
            break;
        case 1:
            [cell setShareType:ShareTypeTencentWeibo];
            break;
        default:
            break;
    }
    return cell;
}
#pragma mark--
#pragma mark tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CellOfBd *celll = (CellOfBd *)[tableView cellForRowAtIndexPath:indexPath];
    [celll shouQuan];
}


@end
