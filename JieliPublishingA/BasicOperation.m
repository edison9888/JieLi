//
//  BasicOperation.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-13.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "BasicOperation.h"
#define BaseURL @"http://www.jielibj.com/ws/webs.php"

@interface BasicOperation (){
    NSString *urlString;
}

@end

@implementation BasicOperation
-(id)initWithUrl:(NSString *)url{
    if (self == [super init]) {
        urlString = [url retain];
    }
    return self;
}
-(void)main{
    
    NSURL *url = [NSURL URLWithString:[[BaseURL stringByAppendingString:urlString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    [self performSelectorOnMainThread:@selector(finish:) withObject:result waitUntilDone:NO];
}

-(void)finish:(id)result{
    [self.delegate finishOperation:result];
}

@end
