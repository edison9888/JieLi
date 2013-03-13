//
//  CategoriesView.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-11-24.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import "CategoriesView.h"

@implementation CategoriesView

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
            [self loadView:self.dataBrain.categoriesArray];
        }
    }
    return self;
}
-(void)finishGetListWithArray:(NSArray *)bookList withType:(int)type{
    switch (type) {
        case DownListTypeOfCategories:
            [self loadView:bookList];
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


-(void)loadView:(NSArray *)categories{
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
