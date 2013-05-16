//
//  CategoriesView.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-11-24.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import "CategoriesView.h"
#import "PicNameMc.h"
@implementation CData

+(id)CDataWithId:(int)n name:(NSString *)na{
    return [[self alloc] initWithId:n name:na];
}
-(id)initWithId:(int)n name:(NSString *)na{
    if (self = [super init]) {
        self.Id = n;
        self.Name = na;
    }
    return self;
}

@end



@interface CategoriesView(){
    NSInteger _currentRow;
    NSInteger _currentSection;

}
@property (nonatomic,strong) NSMutableArray *headList;

@property (nonatomic,strong) NSMutableArray *datilList;
@property (nonatomic, strong) NSMutableArray *headViewArray;
@property (nonatomic,strong) UITableView *tableView;

@end


@implementation CategoriesView

-(NSMutableArray *)headList{
    if (!_headList) {
        _headList = [[NSMutableArray alloc] init];
    }
    return _headList;
}
-(NSMutableArray *)datilList{
    if (!_datilList) {
        _datilList = [[NSMutableArray alloc] init];
    }
    return _datilList;

}
-(NSMutableArray *)headViewArray{
    if (!_headViewArray) {
        _headViewArray = [[NSMutableArray alloc] init];
    }
    return _headViewArray;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10,300,self.frame.size.height) style:UITableViewStyleGrouped];

        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.backgroundView = nil;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        
        
    }
    return _tableView;
}

-(DataBrain *)dataBrain{
    if (!_dataBrain) {
        AppDelegate* app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _dataBrain = app.dataBrain;
    }
    return _dataBrain;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.dataBrain.getListDelegate = self;
        if (![self.dataBrain.categoriesArray count]) {
            [self.dataBrain getBookCategories];
        }
        else{
//            [self loadView:self.dataBrain.categoriesArray];
            [self loadNewView:self.dataBrain.categoriesArray];
        }
    }
    return self;
}
-(void)finishGetListWithArray:(NSArray *)bookList withType:(int)type{
    switch (type) {
        case DownListTypeOfCategories:
//            [self loadView:bookList];
            [self loadNewView:bookList];
//            NSLog(@"%@",bookList);
            break;
            
        case DownListTypeOfCategorieList:{
            self.hidden = YES;
            self.goodBook.isCategoriesViewOpen = YES;
            self.goodBook.myBookShelf.hidden = NO;
            self.goodBook.bookShelfImageList = bookList;
            [self.goodBook.myBookShelf reloadData];
            [self.goodBook.myBookShelf.headerView changeState:k_PULL_STATE_NORMAL];
            [self.goodBook.myBookShelf.footerView changeState:k_PULL_STATE_NORMAL];
            if ([bookList count] ==6) {
                [self.goodBook.myBookShelf setContentOffset:CGPointMake(0, 0) animated:YES];
            }
            [self performSelector:@selector(regainBookShelfcontentInset) withObject:nil afterDelay:.5f];
        }
            break;
        default:
            break;
    }
}
    
    

-(void)regainBookShelfcontentInset{
    self.goodBook.myBookShelf.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}
-(void)readyForData:(NSArray *)categories{
    int partentId = 0;
    for (int i = 1; ; i++) {
        BOOL isHave = NO;
        for (NSDictionary* dic in categories) {
            if(i == [[dic objectForKey:@"parentId"] intValue]){
                isHave = YES;
                partentId = i;
                NSString *parentName = [dic objectForKey:@"parentName"];
                CData *d = [CData CDataWithId:partentId name:parentName];
                [self.headList addObject:d];
                
                break;
            }
        }
        if (isHave) {
            continue;
        }
        else break;
    }
    
    for (CData *d in self.headList) {
        for (NSDictionary* dic in categories) {
            int pId = [[dic objectForKey:@"parentId"] intValue];
            if ( pId == d.Id) {
                CData *data = [CData CDataWithId:[[dic objectForKey:@"categoryId"] intValue] name:[dic objectForKey:@"categoryName"]];
                data.Pid = pId;
                [self.datilList addObject:data];
            }
        }
    }
    
//    NSLog(@"deadList::::%@",self.headList);
//    NSLog(@"datilList::::%@",self.datilList);
    [self logCdataArray:self.headList];
    [self logCdataArray:self.datilList];
}
-(NSArray *)datilArrayWithPid:(int)pId{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (CData *d in self.datilList) {
        if (d.Pid == pId) {
            [array addObject:d];
        }
    }
    return array;
}
-(void)logCdataArray:(NSArray *)data{
    for (CData*d in data) {
        NSLog(@"%d---%d---%@",d.Pid,d.Id,d.Name);
    }
}
-(void)loadNewView:(NSArray *)categories{
    
    _currentRow = -1;
    [self readyForData:categories];

    for (int i= 0 ; i<[self.headList count]; i++) {
//        CData *d = [self.headList objectAtIndex:i];
        HeadView* headview = [[HeadView alloc] init];
        headview.delegate = self;
		headview.section = i;
//        [headview.backBtn setTitle:d.Name forState:UIControlStateNormal];
        [headview.backBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"classification %d",i+1]] forState:UIControlStateNormal];

		[self.headViewArray addObject:headview];
//        headview = nil;
    }
    
    
    [self addSubview:self.tableView];

    
    

}
#pragma mark - TableViewdelegate&&TableViewdataSource

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HeadView* headView = [self.headViewArray objectAtIndex:indexPath.section];
    
    return headView.open?45:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self.headViewArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HeadView* headView = [self.headViewArray objectAtIndex:section];
    return headView.open?5:0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.headViewArray count];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier] autorelease];
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 300, cell.frame.size.height);
        [cell setBackgroundColor:[UIColor clearColor]];
        
        UIImage *image = [UIImage imageNamed:@"the label.png"];
        UIImage *backImage = [PicNameMc defaultBackgroundImage:@"the label.png" size:cell.bounds.size leftCapWidth:image.size.width/2 topCapHeight:0];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:backImage];
        imageView.frame = CGRectMake(5, 0, cell.frame.size.width-10,cell.frame.size.height+1.5);
        [cell addSubview:imageView];
        [cell sendSubviewToBack:imageView];
        
    }
    HeadView* view = [self.headViewArray objectAtIndex:indexPath.section];
    if (view.open) {
        if (indexPath.row == _currentRow) {
        }
    }
    CData *headCD = [self.headList objectAtIndex:indexPath.section];
    CData *d = [[self datilArrayWithPid:headCD.Id] objectAtIndex:indexPath.row];

    cell.textLabel.text = d.Name;
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CData *headCD = [self.headList objectAtIndex:indexPath.section];
    CData *d = [[self datilArrayWithPid:headCD.Id] objectAtIndex:indexPath.row];

    self.dataBrain.categorieListArray = nil;
    [self.dataBrain getCategorieList:d.Id];
    self.currentButtonTag = d.Id;

}

#pragma mark - HeadViewdelegate
-(void)selectedWith:(HeadView *)view{
    _currentRow = -1;
    if (view.open) {
        for(int i = 0;i<[self.headViewArray count];i++)
        {
            HeadView *head = [self.headViewArray objectAtIndex:i];
            head.open = NO;
//            [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
        }
        [_tableView reloadData];
        return;
    }
    _currentSection = view.section;
    [self reset];
    
}
//界面重置
- (void)reset
{
    for(int i = 0;i<[self.headViewArray count];i++)
    {
        HeadView *head = [self.headViewArray objectAtIndex:i];
        
        if(head.section == _currentSection)
        {
            head.open = YES;
//            [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_nomal"] forState:UIControlStateNormal];
            
        }else {
//            [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
            
            head.open = NO;
        }
        
    }
    [_tableView reloadData];
}


//-------------------
-(void)loadView:(NSArray *)categories{
    [self readyForData:categories];
//    NSLog(@"loadViewWithInfo:%@",categories);
    int partentId = 0;
    for (int i = 1; ; i++) {
        BOOL isHave = NO;
        for (NSDictionary* dic in categories) {
            if(i == [[dic objectForKey:@"parentId"] intValue]){
                isHave = YES;
                partentId = i;
//                NSLog(@"partentId:%d",partentId);
                //生成相应的标签
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
                label.textAlignment = NSTextAlignmentLeft;
                label.text = [dic objectForKey:@"parentName"];
                label.tag = i;
                [label setBackgroundColor:[UIColor clearColor]];
                [self addSubview:label];
                break;
            }
        }
        if (isHave) {
            continue;
        } 
        else break;
    }
    int posX = 0;
    int posY = 0;
    
    for (int i = 1; i<=partentId; i++) {
        UILabel *label = (UILabel *)[self viewWithTag:i];
        label.frame  = CGRectMake(20, posY, label.frame.size.width, label.frame.size.height);
        posX = 0;
        posY+=30;
        int btnIndex=1;
        for (NSDictionary* dic in categories) {
            int pId = [[dic objectForKey:@"parentId"] intValue];
            if ( pId == i) {
                NSLog(@"%d,%d",posX,posY);
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.frame = CGRectMake(posX, posY, 160, 30);
                button.tag = [[dic objectForKey:@"categoryId"] intValue];
//                button.titleLabel.text = [dic objectForKey:@"categoryName"];
//                [button.titleLabel setText:@"123"];
                [button setTitle:[dic objectForKey:@"categoryName"] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//                [button setBackgroundColor:[UIColor redColor]];
                [self addSubview:button];
                posX = 160*((btnIndex)%2);
                posY =posY+ 30*((btnIndex+1)%2);
                btnIndex++;
            }
        }
        posY =posY+ 30*((btnIndex+1)%2);
    }
    [self setContentSize:CGSizeMake(0, posY)];
    
//    NSString *s;
}



-(void)buttonPressed:(UIButton *)button{
    NSLog(@"%d",button.tag);
    self.dataBrain.categorieListArray = nil;
    [self.dataBrain getCategorieList:button.tag];
    self.currentButtonTag = button.tag;
    
}

@end
