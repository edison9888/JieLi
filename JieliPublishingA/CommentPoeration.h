//
//  CommentPoeration.h
//  JieliPublishingA
//
//  Created by 花 晨 on 13-3-9.
//  Copyright (c) 2013年 中卡. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommentPoerationDelegate <NSObject>
@optional
-(void)getCommentFinish:(id)r;
-(void)sendCommentFinish:(id)r;


@end


typedef enum {
    CommentGet,
    CommentSend,
}CommentType;

@interface CommentPoeration : NSOperation{
    id target;
    NSURL *url;
    CommentType type;
    
}
@property (strong) id<CommentPoerationDelegate> delegate;
+(id)sendWithTaget:(id)cv userId:(NSString *)userid name:(NSString *)name BookId:(int)bookid content:(NSString *)content stars:(int)starsnumber;
+(id)getWithTaget:(id)cv withBookId:(int)bookid;

@end