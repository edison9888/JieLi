//
//  CollectbookPoeration.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-27.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "CollectbookPoeration.h"
#define BaseURL @"http://www.jielibj.com/ws/webs.php"

@implementation CollectbookPoeration
-(id)initWithBookId:(int)bookId ofType:(CollectType)type{
    
    switch (type) {
        case CollectTypeOfCollectOne:
            
            break;
        case CollectTypeOfDelOne:
            
            break;
        case CollectTypeOfGetList:
            
            break;
            
        default:
            break;
    }
    
    
}


-(void)main{
    
//    NSString *urlString = [NSString stringWithFormat:@"?c=Book&m=getSearchBookList&keyWord=%@",key];
//    NSURL *url = [NSURL URLWithString:[[BaseURL stringByAppendingString:urlString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    
//    [self performSelectorOnMainThread:@selector(finish:) withObject:result waitUntilDone:NO];
}
-(void)finish:(id)result{
    [self.delegate finishPoeration:result];
}

@end
