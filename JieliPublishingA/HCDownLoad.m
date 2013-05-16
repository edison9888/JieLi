//
//  HCDownLoad.m
//  DownLoading
//
//  Created by HuaChen on 13-5-14.
//  Copyright (c) 2013年 HuaChen. All rights reserved.
//

#import "HCDownLoad.h"

@interface HCDownLoad(){
    float p,speed;
    NSURLConnection *conn;
    NSNumber *totalSize;
    NSMutableData *receivedData;
    NSDate *startTime;
    HCDownloadState dlState;
    NSError *failError;
    
    downLoadBegin _block_begin;
    downLoadDoing _block_doing;
    downLoadFinish _block_finish;
    downLoadFail _block_fail;
    
}
@end


@implementation HCDownLoad

+(id)downLoadWithURL:(NSURL *)url{
    return [[self alloc] initDownLoadWithURL:url];
}
+(id)downLoadWithURL:(NSURL *)url begin:(downLoadBegin)begin doing:(downLoadDoing)doing finish:(downLoadFinish)finish fail:(downLoadFail)fail{
    return [[self alloc] initDownLoadWithURL:url begin:begin doing:doing finish:finish fail:fail];
}

-(NSDictionary *)downLoadInfo{
    if (dlState == HCDownloadStateWaiting) {
        return nil;
    }
    unsigned long long total = [totalSize unsignedLongLongValue];
    unsigned long long downloaded = [receivedData length];
    unsigned long long remain= total - downloaded;
    
    float downloadedF, totalF,remainF,speedF;
    char prefix;

    if (total >= 1024 * 1024 * 1024) {
        downloadedF = (float)downloaded / (1024 * 1024 * 1024);
        totalF = (float)total / (1024 * 1024 * 1024);
        remainF = (float)remain / (1024 * 1024 * 1024);
        speedF = speed/(1024 * 1024 * 1024);
        prefix = 'G';
    } else if (total >= 1024 * 1024) {
        downloadedF = (float)downloaded / (1024 * 1024);
        totalF = (float)total / (1024 * 1024);
        remainF = (float)remain / (1024 * 1024);
        speedF = speed/(1024 * 1024 );
        prefix = 'M';
    } else if (total >= 1024) {
        downloadedF = (float)downloaded / 1024;
        totalF = (float)total / 1024;
        remainF = (float)remain / (1024);
        speedF = speed/(1024 );
       prefix = 'k';
    } else {
        downloadedF = (float)downloaded;
        totalF = (float)total;
        remainF = (float)remain;
        speedF = speed;
       prefix = '\0';
    }

    NSString *totalSizeSting = [NSString stringWithFormat:@"%.2f %cB",totalF,prefix];
    NSString *downLoadedSting = [NSString stringWithFormat:@"%.2f %cB",downloadedF,prefix];
    NSString *downLoadRemainString = [NSString stringWithFormat:@"%.2f %cB",downloadedF,prefix];
    NSString *speedString = [NSString stringWithFormat:@"%.2f %cB",speedF,prefix];
    
    int hours = self.timeRemaining / 3600;
    int minutes = (self.timeRemaining - hours * 3600) / 60;
    int seconds = self.timeRemaining - hours * 3600 - minutes * 60;
    NSString *remainTimeString = [NSString stringWithFormat:@"%02d:%02d:%02d",hours,minutes,seconds];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjects:@[totalSizeSting,downLoadedSting,downLoadRemainString,speedString,remainTimeString] forKeys:@[@"totalSize",@"downLoaded",@"downLoadRemain",@"speed",@"reminTime"]];
    return dic;
}

-(NSData *)completeData{
    if (dlState == HCDownloadStateFinished) {
        return receivedData;
    }
    else{
        return nil;
    }
}
-(unsigned long long)contentLength{
    return totalSize?[totalSize unsignedLongLongValue]:0;
}
-(float)progress{
    return p;
}
-(NSTimeInterval)timeRemaining{
    if (!speed||!totalSize) {
        return HCDownloadTimeRemainingUnknown;
    }
    NSTimeInterval t = ([totalSize unsignedLongLongValue]-[receivedData length])/speed;
    return t;
}
-(HCDownloadState)downloadState{
    return dlState;
}
-(NSError *)error{
    if (dlState == HCDownloadStateFailed) {
        return failError;
    }
    else return nil;
}

-(void)cancel{
    [conn cancel];
    dlState = HCDownloadStateCancelled;
}

-(id)initDownLoadWithURL:(NSURL*)url{
    if (self = [super init]) {
        startTime = [NSDate new];
        dlState = HCDownloadStateWaiting;
        NSURLRequest *rq = [NSURLRequest requestWithURL:url];
        conn = [NSURLConnection connectionWithRequest:rq delegate:self];
        if (conn) {
            receivedData = [[NSMutableData alloc] init];
//            [conn start];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
        else{
            NSLog(@"创建下砸链接失败");
        }
    }
    return self;
}

-(id)initDownLoadWithURL:(NSURL *)url begin:(downLoadBegin)begin doing:(downLoadDoing)doing finish:(downLoadFinish)finish fail:(downLoadFail)fail{
    if ((self = [self initDownLoadWithURL:url])) {
        _block_begin = begin;
        _block_doing = doing;
        _block_finish = finish;
        _block_fail = fail;
    }
    return self;
}
- (void)connection:(NSURLConnection *)conn didReceiveResponse:(NSURLResponse *)resp
{   NSLog(@"fileHead:%@",resp.MIMEType);

    dlState = HCDownloadStateActive;
    [receivedData setLength:0];
    long long length = [resp expectedContentLength];
    if (length != NSURLResponseUnknownLength) {
        totalSize = [NSNumber numberWithUnsignedLongLong:(unsigned long long)length];
        [totalSize retain];
//        NSLog(@"size:%f",[totalSize floatValue]);
    }
    if ([self.delegate respondsToSelector:@selector(HCdownloadBegin:)]) {
        [self.delegate HCdownloadBegin:self];
    }
    if (_block_begin) {
        _block_begin();
    }
}

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    if (totalSize) {
        float reL = [receivedData length];
        float toL = [totalSize unsignedLongLongValue];
        p = reL/toL;
//        NSLog(@"progress:%f",p);
    }
    [receivedData appendData:data];
    
    speed = [receivedData length]/[[NSDate new] timeIntervalSinceDate:startTime];

    if ([self.delegate respondsToSelector:@selector(HCdownloadDoing:progress:)]) {
        [self.delegate HCdownloadDoing:self progress:p];
    }
    if (_block_doing) {
        _block_doing(p);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    dlState = HCDownloadStateFinished;
    p =1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if ([self.delegate respondsToSelector:@selector(HCdownloadFinish:withData:)]) {
        [self.delegate HCdownloadFinish:self withData:receivedData];
    }
    if (_block_finish) {
        _block_finish(receivedData);
    }
}

- (void)connection:(NSURLConnection *)conn didFailLoadWithError:(NSError *)error
{
    dlState = HCDownloadStateFailed;
    failError = error;
    [failError retain];
    if ([self.delegate respondsToSelector:@selector(downloadFailed:withError:)]) {
        [self.delegate HCdownloadFailed:self withError:error];
    }
    if (_block_fail) {
        _block_fail(error);
    }
}
@end
