//
//  HCDownLoad.h
//  DownLoading
//
//  Created by HuaChen on 13-5-14.
//  Copyright (c) 2013年 HuaChen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^downLoadBegin)();
typedef void (^downLoadDoing)(float p);
typedef void (^downLoadFinish)(NSData *data);
typedef void (^downLoadFail)(NSError *error);

@class HCDownLoad;

@protocol HCDownLoadDelegate <NSObject>
@optional
- (void)HCdownloadBegin:(HCDownLoad *)downLoad;
- (void)HCdownloadDoing:(HCDownLoad *)downLoad progress:(float)progress;
- (void)HCdownloadFinish:(HCDownLoad *)downLoad withData:(NSData *)data;
- (void)HCdownloadFailed:(HCDownLoad *)downLoad withError:(NSError *)error;
@end

#define HCDownloadTimeRemainingUnknown  -11111
enum {
    HCDownloadStateWaiting,     // Download is inactive, waiting to be downloaded
    HCDownloadStateActive,      // Download is actively downloading
    HCDownloadStatePaused,      // Download was paused by the user
    HCDownloadStateFinished,    // Download is finished, content is available
    HCDownloadStateFailed,      // Download failed
    HCDownloadStateCancelled,   // Download was cancelled
};
typedef NSInteger HCDownloadState;


@interface HCDownLoad : NSObject
// State of the download
@property(nonatomic, readonly) HCDownloadState downloadState;

// Total size of the content, in bytes
@property(nonatomic, readonly) unsigned long long contentLength;

// Failure error, if downloadState is HCDownloadStateFailed
@property(nonatomic, readonly) NSError *error;

// Overall progress for the download [0..1]
@property(nonatomic, readonly) float progress;

// Estimated time remaining to complete the download, in seconds.  Value is HCDownloadTimeRemainingUnknown if estimate is unknown.
@property(nonatomic, readonly) NSTimeInterval timeRemaining;

//if downloadState isn't HCDownloadStateFinished ,return nil;
@property(nonatomic, readonly) NSData *completeData;

//return all infromation with string in dictionary;
@property(nonatomic, readonly) NSDictionary *downLoadInfo;

@property(nonatomic, assign) id<HCDownLoadDelegate> delegate;


+(id)downLoadWithURL:(NSURL*)url;
+(id)downLoadWithURL:(NSURL *)url begin:(downLoadBegin)begin doing:(downLoadDoing)doing finish:(downLoadFinish)finish fail:(downLoadFail)fail;
-(id)initDownLoadWithURL:(NSURL*)url;
-(id)initDownLoadWithURL:(NSURL *)url begin:(downLoadBegin)begin doing:(downLoadDoing)doing finish:(downLoadFinish)finish fail:(downLoadFail)fail;

-(void)cancel;

@end
