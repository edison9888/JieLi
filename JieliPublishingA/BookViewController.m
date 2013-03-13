//
//  BookViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-16.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import "BookViewController.h"
#import "DiyTopBar.h"
#import "PicNameMc.h"
@interface BookViewController ()
@property (strong, nonatomic) IBOutlet DiyTopBar *myTopBar;

@end

@implementation BookViewController

//-(ShareBookView *)shareBookView{
//    
//    if (!_shareBookView) {
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookViewController" owner:self options:nil];
//        _shareBookView = [nib objectAtIndex:1];
//        _shareBookView.frame = CGRectMake(0, 480, 320, _shareBookView.frame.size.height);
//        [self.view addSubview:_shareBookView];
//    }
//    return _shareBookView;
//}

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
    
    
    if (!self.myCoverImageview.image) {
        [self.myCoverImageview setImage:[PicNameMc imageFromImageName:DefaultImage]];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:DefaultImage]];
    imageView.frame = self.myCoverImageview.frame;
    [self.view insertSubview:imageView belowSubview:self.myCoverImageview];
    
    [self.myBgImageView setImage:[PicNameMc imageFromImageName:WoodPattern]];
    
    [self.myBtn_share setImage:[PicNameMc imageFromImageName:F_btn_share] forState:UIControlStateNormal];
    
//    [self.myBtn_readOnLine setBackgroundImage:[PicNameMc imageFromImageName:F_btn_bg] forState:UIControlStateNormal];
//    [self.myBtn_readOnLine setTitle:@"在线阅读" forState:UIControlStateNormal];
//    [self.myBtn_readOnLine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.myBtn_readOnLine setImage:[PicNameMc defaultBackgroundImage:@"rb" withWidth:self.myBtn_readOnLine.frame.size.width withTitle:@"在线阅读" withColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    
    
//    [self.myBtn_compereBuy setBackgroundImage:[PicNameMc imageFromImageName:F_btn_bg] forState:UIControlStateNormal];
//    [self.myBtn_compereBuy setTitle:@"比价购买" forState:UIControlStateNormal];
//    [self.myBtn_compereBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.myBtn_compereBuy setImage:[PicNameMc defaultBackgroundImage:@"rb" withWidth:self.myBtn_compereBuy.frame.size.width withTitle:@"比价购买" withColor:[UIColor whiteColor]] forState:UIControlStateNormal];

    
    
    [self.myBtn_evaShare setImage:[PicNameMc imageFromImageName:F_btn_bg] forState:UIControlStateNormal];
    
    [self.myImageFrame setImage:[PicNameMc imageFromImageName:F_image_woodFrame]];
    
    [self.myTopBar setType:DiyTopBarTypeBackAndCollect];
    self.myTopBar.myTitle.text = @"书籍详情";
    [self.myTopBar.backButton addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.myTopBar.collectButton addTarget:self action:@selector(colloectPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _shareBookView.frame = CGRectMake(0, 480, 320, _shareBookView.frame.size.height);
    _shareBookView.delegate = self;
    [self.view addSubview:_shareBookView];
    
    
    _shareMessageView.frame = CGRectMake(320, 44, 320, _shareMessageView.frame.size.height);
    [self.view addSubview:_shareMessageView];
    
    _buyBookView.frame = CGRectMake(0, 480, 320, _buyBookView.frame.size.height);
    _buyBookView.bookInfo = self.bookInfo;
    [self.view addSubview:_buyBookView];

}





- (IBAction)popBack:(id)sender {
    for (id view in self.view.subviews) {
        if ([view isKindOfClass:[UIWebView class]]) {
            [view removeFromSuperview];
            return;
        }
    }
    if (self.shareBookView.isOut||self.shareMessageView.isOut||self.buyBookView.isOut) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.shareBookView.frame =CGRectMake(0, 480, 320, _shareBookView.frame.size.height);
        
        [UIView commitAnimations];
        
        self.shareBookView.isOut = NO;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.shareMessageView.frame = CGRectMake(320, 44, 320, _shareMessageView.frame.size.height);
        
        [UIView commitAnimations];
        self.shareMessageView.isOut = NO;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.buyBookView.frame = CGRectMake(0, 480, 320, _buyBookView.frame.size.height);
        
        [UIView commitAnimations];
        self.buyBookView.isOut = NO;

        
        
    }
    else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] animated:YES];
    }
}
- (void)colloectPressed:(id)sender {
    NSLog(@"收藏了此书");
}
- (IBAction)readOnlinePressed:(id)sender {
    NSURL *url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"testPdf1"] withExtension:@"pdf"];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, 320, 480-44)];
    [self.view addSubview:webView];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:req];

}
- (IBAction)buyBookPressed:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.buyBookView.frame = CGRectMake(0, 480-self.buyBookView.frame.size.height, 320, self.buyBookView.frame.size.height);
    
    [UIView commitAnimations];
    self.buyBookView.isOut = YES;
    
    
}
- (IBAction)shareBookPressed:(id)sender {
//    ShareBookViewController *viewController = [[ShareBookViewController alloc] initWithNibName:@"ShareBookViewController" bundle:nil];
//    viewController.delegate = self;
//    viewController.bookInfo = self.bookInfo;
//    viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    [self presentModalViewController:viewController animated:YES];
//    
    [self.shareBookView shareBookViewAppear];
    NSString *postStatusText = [NSString stringWithFormat:@"test -- date:%@  bookName:%@",[NSDate new],self.bookInfo.bookName];
    _shareMessageView.textView.text = postStatusText;

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.shareBookView.frame = CGRectMake(0, 480-self.shareBookView.frame.size.height, 320, self.shareBookView.frame.size.height);
    
    [UIView commitAnimations];
    self.shareBookView.isOut = YES;
    
}

#pragma shareDelegate
-(void)pushMessageView{
//    NSString *postStatusText = [NSString stringWithFormat:@"test -- date:%@  bookName:%@",[NSDate new],self.bookInfo.bookName];
//    _shareMessageView.textView.text = postStatusText;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.shareMessageView.frame = CGRectMake(0, 44, 320, self.shareMessageView.frame.size.height);
    
    [UIView commitAnimations];
    self.shareMessageView.isOut = YES;

}
-(NSString *)sendWeiBoWithString{
    return self.shareMessageView.textView.text;
}
-(UIImage *)sendWieBoWithImage{
    return self.myCoverImageview.image;
}


#pragma mark
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)hideTabBar:(UITabBarController *) tabbarcontroller {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, 480, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 480)];
        }
    }
    [UIView commitAnimations];
}

- (void)showTabBar:(UITabBarController *) tabbarcontroller {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        NSLog(@"%@", view);
        
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, 431, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 431)];
        }
    }
    
    [UIView commitAnimations];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideTabBar:self.tabBarController];
}
-(void)viewDidAppear:(BOOL)animated{
    _buyBookView.bookInfo = self.bookInfo;

    [_buyBookView loadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showTabBar:self.tabBarController];
}
- (void)viewDidUnload {
    [self setMyCoverImageview:nil];
    [self setMyBookNameLabel:nil];
    [self setMyAutherNameLabel:nil];
    [self setMyBookTypeLabel:nil];
    [self setMyPublishTimeLabel:nil];
    [self setMyPublishCompanyNameLabel:nil];
    [self setMyBookPriceLabel:nil];
    [self setMyTextView:nil];
    [self setMyTopBar:nil];
    [self setMyBtn_share:nil];
    [self setMyBtn_readOnLine:nil];
    [self setMyBtn_evaShare:nil];
    [self setMyBtn_compereBuy:nil];
    [self setMyImageFrame:nil];
    [self setMyBgImageView:nil];
    [self setShareBookView:nil];
    [self setShareMessageView:nil];
    [self setBuyBookView:nil];
    [super viewDidUnload];
}
@end
