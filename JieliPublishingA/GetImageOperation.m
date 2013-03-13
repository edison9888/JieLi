//
//  GetImageOperation.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-12.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "GetImageOperation.h"
#import "DataBrain.h"
@interface GetImageOperation(){
    int bookId;
    NSString *bookImageUrl;
}
@end
@implementation GetImageOperation
-(id)initWithBookInfo:(BookInfo *)bookInfo{
    if (self == [super init]) {
        bookId = bookInfo.bookId;
        bookImageUrl = bookInfo.bookImage;
    }
    return self;
}
-(void)main{
    
    NSData *data = [DataBrain readFilewithImageId:bookId withFlolderName:BookCoverImage];
    if (data) {
        NSLog(@"从本地读取图片，ID：%d",bookId);
        UIImage *image = [UIImage imageWithData:data];
        [self performSelectorOnMainThread:@selector(finish:) withObject:image waitUntilDone:NO];
    }
    else{
        NSString *imageUrl = bookImageUrl;
        if (imageUrl == nil) {
            NSLog(@"图片缺失,ID:%d",bookId);
        }
        else{
            
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            [self performSelectorOnMainThread:@selector(finish:) withObject:[UIImage imageWithData:data] waitUntilDone:NO];
        }
    }
}

-(void)finish:(UIImage *)image{
    [self.delegate finishGetImage:image];
}

@end
