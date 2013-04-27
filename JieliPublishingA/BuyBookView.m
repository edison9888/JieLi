//
//  BuyBookView.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-1-11.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "BuyBookView.h"
#import "AppDelegate.h"
#import "BuyBookCell.h"

@interface BuyBookView ()
{
    NSMutableArray *arrayOfCells;
}
@end
@implementation BuyBookView

-(DataBrain *)dataBrain{
    if (!_dataBrain) {
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _dataBrain = app.dataBrain;
    }
    return _dataBrain;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib{
    self.dataBrain.getListDelegate = self;
    
    arrayOfCells = [[NSMutableArray alloc] init];
}
-(void)loadData{
    NSLog(@"bookId:%d",self.bookInfo.bookId);
    [self.dataBrain getCrawlList:self.bookInfo.bookId];

}


#pragma mark
#pragma mark -- DataBrainDelegate
-(void)finishGetListWithArray:(NSArray *)bookList withType:(int)type{
    if (type == DownListTypeOfCraw) {
        if ([bookList count]==0) {
            NSLog(@"无信息");
            return;
        }
        self.arrayOfBuyBoooks = nil;
        self.arrayOfBuyBoooks = [[NSArray alloc] initWithArray:bookList];
        NSLog(@"%@",bookList);
        [self.tableView reloadData];
    }
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
    return 67;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d",indexPath.row);
    NSDictionary *dic = [self.arrayOfBuyBoooks objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:[dic objectForKey:@"href"]];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, 320, 480-44)];
    [self.superview addSubview:webView];
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
        image = [UIImage imageNamed:@"F_image_amazon"];
    }
    else if ([tz isEqualToString:@"360buy.com"]) {
        cell.priceLabel.hidden = YES;
        image = [UIImage imageNamed:@"F_image_jingdong"];
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
        image = [UIImage imageNamed:@"F_image_dangdang"];
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
