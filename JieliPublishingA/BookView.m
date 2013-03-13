//
//  BookView.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-1-29.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "BookView.h"
#import "DataBrain.h"
#define  ImageViewWith  80.f
#define  ImageViewHight  116.f
#define LabelHight 30.f
#define AIViewWith 30.f
#define AIViewHight 30.f

@interface BookView ()
//{
//    id taget_;
//    SEL action_;
//}
//@property (assign,nonatomic) id taget_;
//@property (assign,nonatomic) SEL action_;
@end

@implementation BookView
-(void)bookViewBeTouched:(BookView*)bookView{
    
}

+(id)BookViewWithBookInfo:(BookInfo*)bookInfo withPosition:(CGPoint)position{
    
    
    return [[self alloc] initWithFrame:CGRectMake(position.x-ImageViewWith/2, position.y-ImageViewWith/2, ImageViewWith, ImageViewHight+LabelHight) withBookId:bookInfo];
}
+(id)BookViewWithBookInfo:(BookInfo*)bookInfo{
    return [[self alloc] initWithFrame:CGRectMake(0, 0, ImageViewWith, ImageViewHight+LabelHight) withBookId:bookInfo];
}

//-(void)addTaget:(id)taget action:(SEL)action{
//    self.taget_ = taget;
//    self.action_ = action;
//}
-(void)bookViewBeTapped{
//    id tager = self.taget_;
//    SEL action = self.action_;
//    [tager performSelector:action withObject:self];
    [self.delegate bookViewBeTouched:self];
}

-(id)initWithFrame:(CGRect)frame withBookId:(BookInfo*)bookInfo_{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        [self setBackgroundColor:[UIColor clearColor]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bookViewBeTapped)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        self.bookInfo = bookInfo_;
        
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ImageViewWith, ImageViewHight)];
        [view setImage:[UIImage imageNamed:@"defaultImage.png"]];
        [self addSubview:view];
        self.imageView = view;
        view = nil;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, ImageViewHight, ImageViewWith, LabelHight)];
        [self addSubview:label];
        [label setBackgroundColor:[UIColor clearColor]];
        label.numberOfLines = 2;
        [label setFont:[UIFont fontWithName:@"ArialMT" size:12]];

        if (bookInfo_.bookName) {
           label.text = bookInfo_.bookName;
        }
        else{
            label.text = @"";
        }
        self.labelView = label;
        label = nil;
        
        UIActivityIndicatorView *actView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.imageView.center.x, self.imageView.center.y, AIViewWith, AIViewHight)];
        [self addSubview:actView];
        [actView startAnimating];
        self.activityIndicatorView = actView;
        actView = nil;
        
        
        
        NSData *data = [DataBrain readFilewithImageId:bookInfo_.bookId withFlolderName:BookCoverImage];
        if (data) {
            NSLog(@"从本地读取图片，ID：%d",bookInfo_.bookId);
            UIImage *image = [UIImage imageWithData:data];
            [self loadImageViewWithImage:image];
        }
        else{
            NSString *imageUrl = bookInfo_.bookImage;
            if (imageUrl == nil) {
                NSLog(@"图片缺失,ID:%d",bookInfo_.bookId);
            }
            else{
                [self imageBeginLoad:bookInfo_];
            }
        }

        
}
    return self;
}

-(void)loadImageViewWithImage:(UIImage *)image{
    if (!image) {
        return;
    }
    [self.imageView setImage:image];
    [self.activityIndicatorView stopAnimating];
}

-(void)imageBeginLoad:(BookInfo *)bookInfo_{
    NSLog(@"从网络下载图片，ID：%d",bookInfo_.bookId);
    NSURL *url = [NSURL URLWithString:bookInfo_.bookThumb];

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length]>0 &&error == nil) {
            
            [DataBrain writeFile:data withIndex:bookInfo_.bookId withFlolderName:BookCoverImage];
            
            //                NSArray *array = [NSArray arrayWithObjects:data,button,activity, nil];
            
            [self performSelectorOnMainThread:@selector(loadImageViewWithImage:) withObject:[UIImage imageWithData:data] waitUntilDone:NO];
            
            //
        }
        else if ([data length] == 0 && error == nil){
            NSLog(@"Nothing was downloaded.");
        }
        else if (error != nil){
            NSLog(@"Error happened = %@", error);
        }
        
        
    }];
}

-(void)imageFinishLoad:(UIImage *)image{
    [self loadImageViewWithImage:image];
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
