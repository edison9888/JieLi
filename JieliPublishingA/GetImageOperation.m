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
    int imageId;
    NSString *imageUrl;
    NSString *floderName;
}
@end
@implementation GetImageOperation
-(id)initWithImageId:(NSInteger)Id url:(NSString *)url withFloderName:(NSString *)fName{
    if (self == [super init]) {
        imageId = Id;
        imageUrl = url;
        floderName = fName;
    }
    return self;
}
-(void)main{
    
    NSData *data = [DataBrain readFilewithImageId:imageId withFlolderName:floderName];
    if (data) {
        NSLog(@"从本地读取图片，ID：%d",imageId);
        UIImage *image = [UIImage imageWithData:data];
        [self performSelectorOnMainThread:@selector(finish:) withObject:image waitUntilDone:NO];
    }
    else{
        if (imageUrl == nil) {
            NSLog(@"图片缺失,ID:%d",imageId);
        }
        else{
            
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            [DataBrain writeFile:data withIndex:imageId withFlolderName:floderName];
            [self performSelectorOnMainThread:@selector(finish:) withObject:[UIImage imageWithData:data] waitUntilDone:NO];
        }
    }
}

-(void)finish:(UIImage *)image{
    [self.delegate finishGetImage:image];
}

@end
