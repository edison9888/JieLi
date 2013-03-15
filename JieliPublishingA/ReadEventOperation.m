//
//  ReadEventOperation.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-14.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "ReadEventOperation.h"
#define BASEURL @"https://api.douban.com/v2/event/"
#define API_KEY @"?apiKey=078978195e42393f169c684c1ac6abbd"
@interface ReadEventOperation(){
    NSURL *url;
}
@end
@implementation ReadEventOperation
-(id)initWithEventId:(NSInteger)Id{
    self = [super init];
    if (self) {
        NSString *urlString = [BASEURL stringByAppendingString:[NSString stringWithFormat:@"%d",Id]];
        url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"%@",url);
//        url = [NSURL URLWithString:urlString];

    }
    return self;

}
-(void)main{
    
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSLog(@"op:%@",data);
    if (!data) {
        [self cancel];
        return;
    }
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    [self performSelectorOnMainThread:@selector(finish:) withObject:result waitUntilDone:NO];
}
-(void)finish:(id)result{
    [self.delegate finishPoeration:result];
    [self cancel];
}


@end
