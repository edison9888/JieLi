//
//  ReadingActivityViewController.m
//  JieliPublishingA
//
//  Created by 花 晨 on 12-10-24.
//  Copyright (c) 2012年 中卡. All rights reserved.
//

#import "ReadingActivityViewController.h"
#import "DetailInfoOfActivityViewController.h"
#import "PicNameMc.h"
#import <QuartzCore/QuartzCore.h>

enum{
    bgImageOnTag,
    bgImageOffTag
};
@implementation ReadingCard
-(void)awakeFromNib{
    [self.myBgImageView setImage:[PicNameMc imageFromImageName:F_image_poste]];
    [self.ThumbImageView.layer setMasksToBounds:YES];
    [self.ThumbImageView.layer setCornerRadius:10.0f];
    
    [self.joinButton setBackgroundImage:[PicNameMc imageFromImageName:F_btn_joinActivity] forState:UIControlStateNormal];
    [self.shareButton setBackgroundImage:[PicNameMc imageFromImageName:F_btn_shareActivity] forState:UIControlStateNormal];

}


@end


@interface ReadingActivityViewController ()

@end

@implementation ReadingActivityViewController

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
-(void)pushToDetail:(UITapGestureRecognizer *)tap{
    ReadingCard *readingCardView = (ReadingCard *)[tap view];
    NSLog(@".......%d",readingCardView.activityId);
    DetailInfoOfActivityViewController *viewController = [[DetailInfoOfActivityViewController alloc] initWithNibName:@"DetailInfoOfActivityViewController" bundle:nil];
    viewController.activityId = readingCardView.activityId;
    [self.navigationController pushViewController:viewController animated:YES];

}


- (void)viewDidLoad 
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.myRootImageView setImage:[PicNameMc imageFromImageName:WoodPattern]];
    
    
    self.myTopBar.myTitle.text = @"读书活动";
    [self.myTopBar setType:DiyTopBarTypeBack];
    [self.myTopBar.backButton addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];
    self.button_onLine.tag = bgImageOnTag;
    self.button_offLine.tag = bgImageOffTag;

    [self.dataBrain getActivityList];
    self.dataBrain.getListDelegate = self;
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
-(void)loadReadingCard:(NSArray *)array{
    int pageNumber = MIN(10, [self.dataBrain.ActivityList count]);
    self.myPageControl.numberOfPages = pageNumber;
    
    float posX = 0;
    
    for (int i = 0; i<pageNumber; i++) {
        NSDictionary *dic = [self.dataBrain.ActivityList objectAtIndex:i];
        if (!dic) {
            continue;
        }
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReadingCard" owner:self options:nil];
        ReadingCard *view = [nib objectAtIndex:0];
        view.frame = CGRectMake(posX, 0, view.frame.size.width, view.frame.size.height);
        [self.myScrollView addSubview:view];
        
        [self setTextByKey:@"activityName" withDic:dic withLabel:view.titleLabel isCover:YES];
        [self setTextByKey:@"activityDate" withDic:dic withLabel:view.timeLabel isCover:NO];
        [self setTextByKey:@"activityAdress" withDic:dic withLabel:view.addressLabel isCover:NO];
        
        view.activityId = [[dic objectForKey:@"activityId"] integerValue];
        int viewId =-1; 
        viewId =[[dic objectForKey:@"activityId"] integerValue];
        if (viewId ==-1) {
            continue;
        }
        NSData *data = [DataBrain readFilewithImageId:viewId withFlolderName:ActivityImage];
        if (data) {
            NSLog(@"从本地读取图片,ID:%d",viewId);
            
            UIImage *image = [UIImage imageWithData:data ];
            [view.ThumbImageView setImage:image];
            //            image = nil;
            //            NSLog(@"%d readFile end",bookInfo.bookId);
            
        }
        else{
            NSURL *imageUrl = [NSURL URLWithString:[dic objectForKey:@"activityThumbBig"]];
            if (imageUrl == nil) {
                NSLog(@"图片缺失,ID:%d",viewId);
            }
            else{
                
                [self setImageWithId:viewId withImageUrl:(imageUrl) withObject:view];
            }
        }

        
        
        view.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToDetail:)];
        [tap setNumberOfTapsRequired:1];
        tap.delegate = self;
        [view addGestureRecognizer:tap];
        
        posX +=view.frame.size.width;
    }
    [self.myScrollView setContentSize:CGSizeMake(posX, 0)];
    [self.myScrollView setPagingEnabled:YES];
    [self.myScrollView setShowsHorizontalScrollIndicator:NO];
    self.myScrollView.delegate = self;

}

-(void)setImageWithId:(int)subViewId withImageUrl:(NSURL *)url withObject:(id)object{
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length]>0 &&error == nil) {
            
            [DataBrain writeFile:data withIndex:subViewId withFlolderName:ActivityImage];
            
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
    ReadingCard *subView = [array objectAtIndex:1];
    
    UIImage *image = [UIImage imageWithData:data ];
    [subView.ThumbImageView setImage:image];
    image = nil;
    
}



#pragma dataBrainDelegate
-(void)finishGetListWithArray:(NSArray *)bookList withType:(int)type{
    NSLog(@"%@",bookList);
    [self loadReadingCard:bookList];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = self.myScrollView.contentOffset.x /self.myScrollView.bounds.size.width;
    //通过滚动的偏移量来判断目前页面所对应的小白点
    self.myPageControl.currentPage = page;//pagecontroll响应值的变化
}// any offset changes

- (IBAction)changePage:(id)sender {
    int page = self.myPageControl.currentPage;//获取当前pagecontroll的值
    [self.myScrollView setContentOffset:CGPointMake(self.myScrollView.bounds.size.width * page, 0)];//根据pagecontroll的值来改变scrollview的滚动位置，以此切换到指定的页面
}


//- (IBAction)barButtonPressed:(UIButton *)sender {
//    int index = sender.tag;
//    UIImage *image;
//    switch (index) {
//        case bgImageOnTag:
//            image = [PicNameMc imageFromImageName:F_image_on];
//            break;
//        case bgImageOffTag:
//            image = [PicNameMc imageFromImageName:F_image_off];
//            break;
//        default:
//            break;
//    }
//    [self.bgImageView setImage:image];
//    
//
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void)viewDidUnload {
    [self setMyTopBar:nil];
    [self setButton_onLine:nil];
    [self setButton_offLine:nil];
    [self setBgImageView:nil];
    [self setMyScrollView:nil];
    [self setMyPageControl:nil];
    [self setMyRootImageView:nil];
    [super viewDidUnload];
}
@end