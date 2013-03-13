//
//  CommentPoeration.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-9.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentPoeration : NSOperation{
    id target;
    int bookId;
}
-(id)initWithTaget:(id)cv withBookId:(int)bookid;
@end