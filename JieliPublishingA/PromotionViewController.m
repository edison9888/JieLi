//
//  PromotionViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-16.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import "PromotionViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PicNameMc.h"
@implementation PersonalitySubView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

-(void)awakeFromNib{
    [self setBackgroundColor:[UIColor clearColor]];
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.frame, 5, 2)];
    [backImageView setImage:[PicNameMc defaultBackgroundImage:@"promotionbox" size:backImageView.frame.size leftCapWidth:7 topCapHeight:7]];
    [self addSubview:backImageView];
    [self sendSubviewToBack:backImageView];
    
    [self.linkImageView setImage:[PicNameMc PromotionActLinkImage] ];
    
    [self.myimageBar setImage:[PicNameMc imageFromImageName:F_image_woodBar1]];
    self.myImageView.backgroundColor = [UIColor grayColor];
    [self.myImageView.layer setShadowRadius:2];
    [self.myImageView.layer  setShadowOpacity:0.7];
    [self.myImageView.layer setShadowOffset:CGSizeMake(3, 3)];
    [self.myImageView.layer  setShadowColor:[UIColor blackColor].CGColor];
    [self.myImageView.layer  setBorderWidth:2];
    [self.myImageView.layer  setBorderColor:[UIColor whiteColor].CGColor];

}
- (IBAction)linkPressed:(id)sender {
    NSLog(@"转到%@",self.myLink);
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jielibj.com/"]];
    NSURL *url = [NSURL URLWithString:@"http://www.jielibj.com/"];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,44, 320, 480-44-44-24)];
    [self.superview.superview addSubview:webView];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:req];

}

- (void)dealloc {
    [_linkImageView release];
    [super dealloc];
}
@end


@interface PromotionViewController ()

@end

@implementation PromotionViewController
-(DataBrain *)dataBrain{
    if (!_dataBrain) {
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _dataBrain = app.dataBrain;
    }
    return _dataBrain;
}

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
    if (![self.dataBrain.promotionList count]) {
        [self.dataBrain getPromotionList];
        
        [self.ActI startAnimating];
    }
    else{
        [self loadPersonalitySubView:self.dataBrain.promotionList];
        [self.ActI removeFromSuperview];
    }
    
    
    self.dataBrain.getListDelegate = self;
    
//    self.alertView = [[UIAlertView alloc] initWithTitle:@"正在加载网络列表" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
//    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150, 50, 60, 60)];
//    [self.alertView addSubview:act];
//    [act startAnimating];
//    [self.alertView show];


    
    
    [self.myTopBar setType:DiyTopBarTypeBack];
    self.myTopBar.myTitle.text = @"促销优惠";
    [self.myTopBar.backButton addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.myBgImageView setImage:[PicNameMc backGroundImage]];
}


-(void)loadPersonalitySubView:(NSArray *)array{
    int num = 0;
//    NSLog(@"%@",array);
    float heightP;
    for (int i = 0; i<[array count]; i++) {

        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PromotionCard" owner:self options:nil];
        PersonalitySubView *subView = [nib objectAtIndex:0];
        heightP = subView.frame.size.height;
        subView.frame = CGRectMake(0, num*(heightP+4), self.myScrollerView.frame.size.width,heightP);
        [self.myScrollerView addSubview:subView];
        NSDictionary *dic = [array objectAtIndex:i];
        NSLog(@"%@",dic);
        NSString *promotionName = [NSString stringWithString:[dic objectForKey:@"promotionName"]];
        if (promotionName) {
            subView.myTitleLabel.text =promotionName;
        }
        
        NSString *promotionBrief = [dic objectForKey:@"promotionBrief"];
        if (promotionBrief) {
            subView.resumeLamel.text = [subView.resumeLamel.text stringByAppendingString:promotionBrief];
        }
        
        NSString *promotionDate = [dic objectForKey:@"promotionPeriod"];
        if (promotionDate) {
            subView.timeLabel.text = [subView.timeLabel.text stringByAppendingString:promotionDate];

        }
        
        NSString *promotionAddress = [dic objectForKey:@"promotionAddress"];
        if (promotionAddress) {
            subView.addressLabel.text = [subView.addressLabel.text stringByAppendingString:promotionAddress];

        }
        
        subView.myLink = [dic objectForKey:@"promotionURL"];
        
        int subViewId = [[dic objectForKey:@"promotionId"] integerValue];

        NSData *data = [DataBrain readFilewithImageId:subViewId withFlolderName:PromotionImage];
        if (data) {
            NSLog(@"从本地读取图片,ID:%d",subViewId);
            
            UIImage *image = [UIImage imageWithData:data ];
            [subView.myImageView setImage:image];
            //            image = nil;
            //            NSLog(@"%d readFile end",bookInfo.bookId);
            
        }
        else{
            NSURL *imageUrl = [NSURL URLWithString:[dic objectForKey:@"promotionThumb"]];
            if (imageUrl == nil) {
                NSLog(@"图片缺失,ID:%d",subViewId);
            }
            else{
                
                [self setImageWithId:subViewId withImageUrl:(imageUrl) withObject:subView];
            }
        }
        num++;
        
    }
    [self.myScrollerView setContentSize:CGSizeMake(0, num*(heightP+4))];
    

        
}

-(void)setImageWithId:(int)subViewId withImageUrl:(NSURL *)url withObject:(id)object{
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length]>0 &&error == nil) {
            
            [DataBrain writeFile:data withIndex:subViewId withFlolderName:PromotionImage];
            
            NSArray *array = [NSArray arrayWithObjects:data,object, nil];
            
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
-(void)loadImage:(NSArray *)array{
    NSData *data = [array objectAtIndex:0];
    PersonalitySubView *subView = [array objectAtIndex:1];
    
    UIImage *image = [UIImage imageWithData:data ];
    [subView.myImageView setImage:image];
    
    image = nil;
    
}


#pragma databrainDelegate
-(void)finishGetListWithArray:(NSArray *)bookList withType:(int)type{
//    NSLog(@"促销优惠列表：%@",self.dataBrain.promotionList);
    [self loadPersonalitySubView:self.dataBrain.promotionList];
    
//    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
    [self.ActI stopAnimating];
    [self.ActI removeFromSuperview];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popBack:(id)sender {
    NSLog(@"%@",self.view.subviews);
    for (id view in self.view.subviews) {
        if ([view isKindOfClass:[UIWebView class]]) {
            [view removeFromSuperview];
            return;
        }
    }

    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void)viewDidUnload {
    [self setMyScrollerView:nil];
    [self setMyTopBar:nil];
    [self setMyBgImageView:nil];
    [self setActI:nil];
    [super viewDidUnload];
}
@end
