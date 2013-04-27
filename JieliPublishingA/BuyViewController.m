//
//  BuyViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-6.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "BuyViewController.h"
#import "AppDelegate.h"
#import "BuyBookCell.h"
#import "CBuyOperation.h"
#import "PicNameMc.h"

@interface BuyViewController (){
    NSMutableArray *arrayOfCells;
    CBuyOperation *op;
}
@end

@implementation BuyViewController


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
    arrayOfCells = [[NSMutableArray alloc] init];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadBookInfo:(BookInfo *)info{
    self.bookInfo = info;
//    [self.dataBrain getCrawlList:self.bookInfo.bookId];
    op = [[CBuyOperation alloc] initWithTaget:self withBookId:self.bookInfo.bookId];
    [[AppDelegate shareQueue] addOperation: op];
//    [[AppDelegate shareQueue] ]


}
-(void)viewDidDisappear:(BOOL)animated{
    if (!op.isFinished) {
        [op cancel];

    }
}
#pragma mark
#pragma mark -- 

-(void)loadData:(id)result{
    NSLog(@"%@",result);
    if ([result isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.arrayOfBuyBoooks = [[NSArray alloc] initWithArray:result];
    [self.tableView reloadData];

}






#pragma mark
#pragma mark -- BuyBookView tebleView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrayOfBuyBoooks count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d",indexPath.row);
    NSDictionary *dic = [self.arrayOfBuyBoooks objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:[dic objectForKey:@"href"]];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, 320, 480-44)];
    [self.view.superview.superview addSubview:webView];
    NSLog(@"%@",webView);
//    [self.view.superview bringSubviewToFront:webView];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:req];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BuyBookCell" owner:self options:nil];
    BuyBookCell *cell = [nib objectAtIndex:0];
    
    
    UIImage *image;
    NSDictionary *dic = [self.arrayOfBuyBoooks objectAtIndex:indexPath.row];
    NSString *price = [dic objectForKey:@"price_now"];
    price = [@"¥" stringByAppendingString:price];
    cell.priceLabel.text = price;
    
    NSString *tz = [dic objectForKey:@"source_web"];
    
    if ([tz isEqualToString:@"amazon.com"]) {
        image = [[PicNameMc imageName:@"buyBookCellImages@2x.png" numberOfH:3 numberOfW:1] objectAtIndex:1];
    }
    else if ([tz isEqualToString:@"360buy.com"]) {
        cell.priceLabel.hidden = YES;
        image = [[PicNameMc imageName:@"buyBookCellImages@2x.png" numberOfH:3 numberOfW:1] objectAtIndex:2];
        NSURL *url = [NSURL URLWithString:[dic objectForKey:@"price_now_url"]];
        
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if ([data length]>0 &&error == nil) {
                
                UIImage *urlImage = [UIImage imageWithData:data];
                NSArray *array = [[NSArray alloc] initWithObjects:cell,urlImage, nil];
                
                
                [self performSelectorOnMainThread:@selector(loadImage:) withObject:array waitUntilDone:NO];
                
            }
            else if ([data length] == 0 && error == nil){
                NSLog(@"Nothing was downloaded.");
            }
            else if (error != nil){
                NSLog(@"Error happened = %@", error);
            }
        }];
        
    }
//    else if ([tz isEqualToString:@"dangdang.com"]) {
    else{
        image = [[PicNameMc imageName:@"buyBookCellImages@2x.png" numberOfH:3 numberOfW:1] objectAtIndex:0];
    }
    
    [cell.logoImageView setImage:image];
    
    return cell;
    
}
-(void)loadImage:(NSArray *)array{
    BuyBookCell *cell = [array objectAtIndex:0];
    UIImage *image = [array objectAtIndex:1];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(cell.priceLabel.frame.origin.x, cell.priceLabel.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
    [cell addSubview:imageView];
}



@end
