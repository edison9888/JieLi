//
//  CommentPoeration.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-9.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "CommentPoeration.h"
#define BaseURL @"http://www.jielibj.com/ws/webs.php"

@implementation CommentPoeration
-(id)initWithTaget:(id)cv withBookId:(int)bookid{
    if (self == [super init]) {
        target = cv;
        bookId = bookid;
    }
    return self;
}
-(void)main{
    
    NSString *urlString = [NSString stringWithFormat:@"??c=Book&m=getComment&bookId=%d",bookId];
    NSURL *url = [NSURL URLWithString:[[BaseURL stringByAppendingString:urlString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    [target performSelectorOnMainThread:@selector(loadData:) withObject:result waitUntilDone:NO];
    
}

@end