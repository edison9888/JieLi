//
//  MemberAreaViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-24.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import "MemberAreaViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PicNameMc.h"
#import "AppDelegate.h"
#import "LogViewController.h"
@interface MemberAreaViewController (){
    NSArray *arrayOfCells;
    UIScrollView *scrollView;
}
@property (strong,nonatomic) UIView *bgImageView;

@end

@implementation MemberAreaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{

}
-(void)finishOperation:(id)result{
    NSLog(@"%@",result);
    [self.actI stopAnimating];
    [self.actI removeFromSuperview];

    [self logSuccessWithMemberInfo:result];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
}

- (IBAction)batButtonPressed:(UIButton*)sender {
    int index = sender.tag;
    NSLog(@"%d",sender.tag);
    UIImage *image = nil;
    self.currentType = index-1;
    [self.tableView reloadData];
    scrollView.hidden = YES;

    if (index ==1) {
        self.tableView.hidden = YES;
        self.informationView.hidden = NO;
    }
    else{
        self.tableView.hidden = NO;
        self.informationView.hidden = YES;
        if (index == 3) {
            self.tableView.hidden = YES;
            scrollView.hidden = NO;
        }
    }
    switch (index) {
        case 1:
            image = [PicNameMc imageFromImageName:F_image_bgOfVip1];
            break;
        case 2:
            image = [PicNameMc imageFromImageName:F_image_bgOfVip2];
            break;
        case 3:
            image = [PicNameMc imageFromImageName:F_image_bgOfVip3];
            break;
        case 4:
            image = [PicNameMc imageFromImageName:F_image_bgOfVip4];
            break;
        default:
            break;
    }
    [self.meberAreaTopBar setImage:image];
}

-(void)loadLoginView{
    
}

-(void)loadMemberAreaView{
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self.myBgImageView setImage:[PicNameMc backGroundImage]];
    [self.meberAreaTopBar setImage:[PicNameMc imageFromImageName:F_image_bgOfVip1]];


    [self.myTopBar setType:DiyTopBarTypeBack];
    self.myTopBar.myTitle.text = @"会员专区";
    [self.myTopBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    self.barButon1.tag = 1;
    self.barButon2.tag = 2;
    self.barButon3.tag = 3;
    self.barButon4.tag = 4;
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.tableView.frame];
    UIImageView *jiFen = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"The rules"]];
    jiFen.frame = CGRectMake(5, 0, 618/2, 1795/2);
    [scrollView addSubview:jiFen];
    scrollView.hidden = YES;
    [self.myMemberAreaView addSubview:scrollView];
    scrollView.contentSize = jiFen.frame.size;
    [self.myMemberAreaView bringSubviewToFront:self.meberAreaTopBar];
    [scrollView setShowsVerticalScrollIndicator:NO];
    
    
    
    self.myMemberAreaView.hidden = YES;
//    [self logView];
    
    NSArray *titles = @[@"基本信息",@"密码修改",@"注册资料补全",@"收货地址管理",@"收藏的图书",@"购买的图书",@"积分详情",@"积分兑换",@"积分规则",@"积分银行",@"分享的书籍",@"分享的书店",@"分享的活动",@"分享的优惠"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<[titles count]; i++) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellA" owner:self options:nil];
        CellA *cell = [nib objectAtIndex:0];

        cell.titleLabel.text = [titles objectAtIndex:i];
        [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"F_image_member_%d",i+1]]];
        
        switch (i) {
            case 5:
                cell.type = 1;
                break;
            case 10:
                cell.type = 3;
                break;
            case 12:
                cell.type = 3;
                break;
                
            default:
                break;
        }
        
//        if (i<4) {
//            cell.type = 0;
//        }
//        else if (i>=4&&i<6){
//            cell.type = 1;
//        }
//        else if (i>=6&&i<10){
//            cell.type = 2;
//        }
//        else {
//            cell.type = 3;
//        }
        [array addObject:cell];
        NSLog(@"title:%@",cell.titleLabel.text);

    }
    arrayOfCells = [[NSArray alloc] initWithArray:array];
    self.currentType = 0;
    
    
    if (self.memberInfo) {
        [self logSuccessWithMemberInfo:self.memberInfo];
        return;
    }
    if (![AppDelegate dAccountName]) {
        LogViewController *viewController = [[LogViewController alloc] initWithNibName:@"LogViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [self.actI removeFromSuperview];
    }
    else{
        NSString *urlString = [NSString stringWithFormat:@"?c=Member&m=login&user=%@&password=%@",[AppDelegate dAccountName],[AppDelegate dPassWord]];
        
        BasicOperation *op = [[BasicOperation alloc] initWithUrl:urlString];
        op.delegate = self;
        [[AppDelegate shareQueue] addOperation:op];
        [self.actI startAnimating];
    }

}


- (void)logView {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LogAndRegister" owner:self options:nil];
    LogAndRegister *view = [nib objectAtIndex:0];
    view.delegate = self;
    view.bgImageView = self.bgImageView;
//    view.pointToView = self.myMemberAreaView;
    [self.view addSubview:view];
    view.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height);
    self.logAndRegisterView = view;
}

#pragma mark LogAndRegister Delegate
-(void)cancleBack{
    [self popBack];
}
-(void)logSuccessWithMemberInfo:(NSDictionary *)dic{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MemberInformationView" owner:self options:nil];
    MemberInformationView *view = [nib objectAtIndex:0];
    view.partentViewController = self;
    [view showInformationWith:dic];
    view.frame = CGRectMake(-320, 37, view.frame.size.width, view.frame.size.height);
    self.informationView = view;
    [self.myMemberAreaView insertSubview:view belowSubview:self.meberAreaTopBar];
    self.myMemberAreaView.hidden = NO;
    
    
    
    
}




#pragma mark-- tabelView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int number = 0;
    switch (self.currentType) {
        case 0:
            number = 0;
            break;
        case 1:
            number = 1;
            break;
        case 2:
            number = 0;
            break;
        case 3:
            number = 2;
            break;
            
        default:
            break;
    }
    return number;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellA *cell = [arrayOfCells objectAtIndex:0];
    return cell.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    NSInteger row = indexPath.row;
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (CellA *cell in arrayOfCells) {
//        NSLog(@"cellType:%d title:%@",cell.type,cell.titleLabel.text);
        
        if (cell.type == self.currentType) {
            [array addObject:cell];
        }
    }
    CellA *cell = [array objectAtIndex:row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)popBack {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)log_in:(id)sender {
//    if ([self.userNameLabel.text isEqualToString:useName]&&[self.passWordLabel.text isEqualToString:passWord]) {
//        self.log_in.hidden = YES;
//        self.login.hidden = YES;
//        self.log_ined.hidden = NO;
//        self.logout.hidden = NO;
//        [self.passWordLabel endEditing:YES];
//        [self.userNameLabel endEditing:YES];
//        
//    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return NO;
    
}

- (void)viewDidUnload {
    [self setMyTopBar:nil];
    [self setBarButon1:nil];
    [self setBarButon2:nil];
    [self setBarButon3:nil];
    [self setBarButon4:nil];
    [self setMyBgImageView:nil];
    [self setMyMemberAreaView:nil];
    [self setMeberAreaTopBar:nil];
    [self setTableView:nil];
    [self setActI:nil];
    [super viewDidUnload];

}


@end
