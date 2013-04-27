//
//  GetCategorieInformationOperation.m
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-30.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import "GetCategorieInformationOperation.h"
#define BaseURL @"http://www.jielibj.com/ws/webs.php"

@implementation GetCategorieInformationOperation





-(void)main{
//    NSString *urlString = [NSString stringWithFormat:@"?c=Book&m=getBookCategories"];
//    NSData *data = [NSData dataWithContentsOfURL:urlString];
//    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

    
    [self performSelectorOnMainThread:@selector(finish:) withObject:nil waitUntilDone:NO];
}

-(void)finish:(NSDictionary *)dic{
    
    [self.delegate getCategorieInformationFinish:dic];
    
    
    
}
@end
