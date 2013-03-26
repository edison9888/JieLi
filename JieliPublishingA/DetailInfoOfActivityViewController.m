//
//  DetailInfoOfActivityViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-24.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import "DetailInfoOfActivityViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PicNameMc.h"
#import "DataBrain.h"
#import "ShareViewController.h"

@interface DetailInfoOfActivityViewController (){
    ShareViewController *svc;
}

@end

@implementation DetailInfoOfActivityViewController

- (IBAction)jion:(id)sender {
}

- (IBAction)share:(id)sender {
    
    svc = [[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil];
//    svc.view.backgroundColor = [UIColor whiteColor];
    svc.textView.text = [self.myTextView.text retain];
    svc.sendImage = [self.myImageView.image retain];
    
	self.popupView.layer.cornerRadius = 12;
    self.popupView.layer.shadowOpacity = 0.7;
    self.popupView.layer.shadowOffset = CGSizeMake(6, 6);
    self.popupView.layer.shouldRasterize = YES;
    self.popupView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    [self.popupView setFrame:CGRectMake(0, 0, svc.view.frame.size.width,svc.view.frame.size.height+40)];
    [self.popupView addSubview:svc.view];
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    UIImage* closeImage = [UIImage imageNamed:@"SinaWeibo.bundle/images/close"];
    UIColor* color = [UIColor colorWithRed:167.0/255 green:184.0/255 blue:216.0/255 alpha:1];
    [closeButton setImage:closeImage forState:UIControlStateNormal];
    [closeButton setTitleColor:color forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [closeButton addTarget:self action:@selector(cancel)
          forControlEvents:UIControlEventTouchUpInside];
    closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    closeButton.showsTouchWhenHighlighted = YES;
    closeButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.popupView addSubview:closeButton];

    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,80, 40)];
    sendButton.center = CGPointMake(self.popupView.frame.size.width/2, self.popupView.frame.size.height-sendButton.frame.size.height/2);
    [sendButton setImage:[PicNameMc redBg:sendButton title:@"发送分享"] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendWeiBo) forControlEvents:UIControlEventTouchUpInside];
     [self.popupView addSubview:sendButton];
    
    [ASDepthModalViewController presentView:self.popupView withBackgroundColor:nil popupAnimationStyle:ASDepthModalAnimationDefault];

    
}
-(void)cancel{
    [ASDepthModalViewController dismiss];
}
-(void)sendWeiBo{
    [svc sendWeiBo];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)getDouBanInformation{
    ReadEventOperation *op = [[ReadEventOperation alloc] initWithEventId:self.activityId];
    op.delegate = self;
    [[AppDelegate shareQueue] addOperation:op];
    

    
}
-(void)finishPoeration:(id)result{
    NSLog(@"asldkjflsakdjf:%@",result);
    GetImageOperation *op = [[GetImageOperation alloc] initWithImageId:self.activityId url:[result objectForKey:@"image"] withFloderName:ActivityImage];
    op.delegate = self;
    [[AppDelegate shareQueue] addOperation:op];
    
    

    
    [self.myTitleLabel setText:[result objectForKey:@"title"]];
    [self.myTime setText:[self.myTime.text stringByAppendingString:[NSString stringWithFormat:@"%@--%@",[result objectForKey:@"begin_time"],[result objectForKey:@"end_time"]]] ];
    [self.myAdress setText:[self.myAdress.text stringByAppendingString:[result objectForKey:@"address"]]];
    [self.myTextView setText:[result objectForKey:@"content"]];
    CGSize size = [self.myTextView.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(320, self.myTextView.text.length) lineBreakMode:UILineBreakModeWordWrap];
    self.myTextView.frame = CGRectMake(self.myTextView.frame.origin.x, self.myTextView.frame.origin.y, [UIScreen mainScreen].bounds.size.width, size.height+20);
    self.myScrollView.contentSize = CGSizeMake(0, MAX(self.myTextView.frame.origin.y+size.height+20, [UIScreen mainScreen].bounds.size.height));
    
    NSDictionary *dic = [result objectForKey:@"owner"];
    [self.mySponsor setText:[dic objectForKey:@"name"]];


}
-(void)finishGetImage:(UIImage *)image{
    [self.myImageView setImage:image];
}


-(void)getInformation{
    NSLog(@"从网络获取读书活动详情");
    NSString *urlString = [NSString stringWithFormat:@"?c=Activity&m=getActivityDetail&activityId=%d",self.activityId];
    NSLog(@"%@",urlString);
    NSURL *url = [NSURL URLWithString:[[BaseURL stringByAppendingString:urlString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length]>0 &&error == nil) {
            id result =[NSJSONSerialization JSONObjectWithData:data
                                                       options:kNilOptions error:&error];
//            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:result];
//            NSMutableArray *array = [NSMutableArray arrayWithArray:result];
            NSLog(@"获取成功。");
            [self performSelectorOnMainThread:@selector(loadInformation:) withObject:result waitUntilDone:NO];
        }
        else if ([data length] == 0 && error == nil){
            NSLog(@"没有东西被下载。"); }
        else if (error != nil){
            NSLog(@"发生错误 = %@", error);
        }
    }];
}
-(void)setTextByKey:(NSString *)key withDic:(NSDictionary *)dic withLabel:(UILabel *)label isCover:(BOOL)isCover{
    NSString *text = [dic objectForKey:key];
    if (isCover) {
        label.text = text;
    }
    else{
        label.text = [label.text stringByAppendingString:text];
    }
}

-(void)loadInformation:(NSDictionary *)dic{
//    NSLog(@"loadInformation:%@\n number:%d",array,[array count]);
//    NSDictionary *dic = [array objectAtIndex:0];
    NSLog(@"%@",dic);
    [self setTextByKey:@"activityName" withDic:dic withLabel:self.myTitleLabel isCover:YES];
    [self setTextByKey:@"activityDate" withDic:dic withLabel:self.myTime isCover:NO];
    [self setTextByKey:@"activityAdress" withDic:dic withLabel:self.myAdress isCover:NO];
    self.myAdress.numberOfLines = 0;
    self.myTextView.text = [dic objectForKey:@"activityBrief"];
    self.mySponsor.text = [self.mySponsor.text stringByAppendingString:[dic objectForKey:@"activityOrganizer"]];
    
    CGSize size = [self.myTextView.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(320, self.myTextView.text.length) lineBreakMode:UILineBreakModeWordWrap];
    self.myTextView.frame = CGRectMake(self.myTextView.frame.origin.x, self.myTextView.frame.origin.y, [UIScreen mainScreen].bounds.size.width, size.height+20);
    self.myScrollView.contentSize = CGSizeMake(0, MAX(self.myTextView.frame.origin.y+size.height+20, [UIScreen mainScreen].bounds.size.height));

    [self loadThumb:dic];
    
    NSArray *photoArray = [dic objectForKey:@"1"];
    //活动照片
    [self.myPhotoScrollView setShowsHorizontalScrollIndicator:NO];
    int numberOfPhoto = [photoArray count];
    self.myPhotoNumber.text = [NSString stringWithFormat:@"(%d)",numberOfPhoto];
    int width = 45;
    int index = 0;
    for (int i = 0; i<numberOfPhoto; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((width+6)*index++ +5, 5, width, self.myPhotoScrollView.frame.size.height-10)];
        [imageView setBackgroundColor:[UIColor blueColor]];
        [self.myPhotoScrollView addSubview:imageView];
        
        [imageView setBackgroundColor:[UIColor grayColor]];
        [imageView.layer setShadowRadius:2];
        [imageView.layer  setShadowOpacity:0.7];
        [imageView.layer setShadowOffset:CGSizeMake(1, 1)];
        [imageView.layer  setShadowColor:[UIColor blackColor].CGColor];
        //self.myImageView设置边框
        //        [imageView.layer  setCornerRadius:5];
        [imageView.layer  setBorderWidth:2];
        [imageView.layer  setBorderColor:[UIColor whiteColor].CGColor];
        
        NSDictionary *dicc = [photoArray objectAtIndex:i];
        [self loadPhoto:dicc withTag:i withObject:imageView];
        
    }
    [self.myPhotoScrollView setContentSize:CGSizeMake(MAX(index*51+7, [UIScreen mainScreen].bounds.size.width), 0)];

}
-(void)loadImage:(NSArray *)array{
    NSData *data = [array objectAtIndex:0];
    UIImageView *subView = [array objectAtIndex:1];
    
    UIImage *image = [UIImage imageWithData:data ];
    [subView setImage:image];
    
    image = nil;
    
}

-(void)setImageWithId:(int)subViewId withImageUrl:(NSURL *)url withObject:(id)object{
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length]>0 &&error == nil) {
            
            [DataBrain writeFile:data withIndex:subViewId withFlolderName:ActivityCardImage];
            
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
-(void)loadThumb:(NSDictionary *)dic{
    int imageId = self.activityId;
    NSData *data = [DataBrain readFilewithImageId:imageId withFlolderName:ActivityCardImage];
    if (data) {
        NSLog(@"从本地读取图片,ID:%d",imageId);
        
        UIImage *image = [UIImage imageWithData:data ];
        [self.myImageView setImage:image];
    }
    else{
        NSURL *imageUrl = [NSURL URLWithString:[dic objectForKey:@"activityThumb"]];
        if (imageUrl == nil) {
            NSLog(@"图片缺失,ID:%d",imageId);
        }
        else{
            [self setImageWithId:imageId withImageUrl:(imageUrl) withObject:self.myImageView];
        }
    }
}
-(void)loadPhoto:(NSDictionary *)dic withTag:(int)tag withObject:(UIImageView *)photo{
    int imageId = self.activityId*10000 +tag;
    NSData *data = [DataBrain readFilewithImageId:imageId withFlolderName:ActivityCardImage];
    if (data) {
        NSLog(@"从本地读取图片,ID:%d",imageId);
        
        UIImage *image = [UIImage imageWithData:data ];
        [photo setImage:image];
    }
    else{
        NSURL *imageUrl = [NSURL URLWithString:[dic objectForKey:@"photoUrl"]];
        if (imageUrl == nil) {
            NSLog(@"图片缺失,ID:%d",imageId);
        }
        else{
            [self setImageWithId:imageId withImageUrl:(imageUrl) withObject:photo];
        }
    }

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.myBgImageView setImage:[PicNameMc imageFromImageName:WoodPattern]];
    
    [self.myBtn_join setBackgroundImage:[PicNameMc defaultBackgroundImage:@"rb" withWidth:self.myBtn_join.frame.size.width withTitle:@"参加" withColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.myBtn_share setBackgroundImage:[PicNameMc defaultBackgroundImage:@"rb" withWidth:self.myBtn_share.frame.size.width withTitle:@"分享" withColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    
    [self.myPhotoBg setImage:[PicNameMc imageFromImageName:F_image_photoBg]];
    [self.myBtn_left setImage:[PicNameMc imageFromImageName:F_btn_dirLeft]];
    [self.myBtn_right setImage:[PicNameMc imageFromImageName:F_btn_dirRight]];

    
    [self.myScrollView setShowsVerticalScrollIndicator:NO];
    //顶部标题条
    [self.myTopBar setType:DiyTopBarTypeBack];
    self.myTopBar.myTitle.text = @"活动详情";
    [self.myTopBar.backButton addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];

    //书籍封面展示图
    [self.myImageView setBackgroundColor:[UIColor grayColor]];
    [self.myImageView.layer setShadowRadius:2];
    [self.myImageView.layer  setShadowOpacity:0.7];
    [self.myImageView.layer setShadowOffset:CGSizeMake(3, 3)];
    [self.myImageView.layer  setShadowColor:[UIColor blackColor].CGColor];
    //self.myImageView设置边框
    //        [imageView.layer  setCornerRadius:5];
    [self.myImageView.layer  setBorderWidth:2];
    [self.myImageView.layer  setBorderColor:[UIColor whiteColor].CGColor];
    //        imageView.layer.masksToBounds = YES;

    
    
    
//    [self getInformation];
    [self getDouBanInformation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popBack:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

- (void)viewDidUnload {
    [self setMyImageView:nil];
    [self setMyScrollView:nil];
    [self setMyTime:nil];
    [self setMyAdress:nil];
    [self setMySponsor:nil];
    [self setMyPhotoNumber:nil];
    [self setMyTextView:nil];
    [self setMyScrollView:nil];
    [self setMyPhotoScrollView:nil];
    [self setMyTopBar:nil];
    [self setMyBtn_join:nil];
    [self setMyBtn_share:nil];
    [self setMyPhotoBg:nil];
    [self setMyBtn_left:nil];
    [self setMyBtn_right:nil];
    [self setMyBgImageView:nil];
    [self setMyTitleLabel:nil];
    [self setPopupView:nil];
    [super viewDidUnload];
}
- (void)dealloc {
    [_popupView release];
    [super dealloc];
}
@end
