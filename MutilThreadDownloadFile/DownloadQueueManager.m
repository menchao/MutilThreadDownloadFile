//
//  DownloadQueueManager.m
//  MutilThreadDownloadFile
//
//  Created by 门超 on 15/5/5.
//  Copyright (c) 2015年 intel. All rights reserved.
//

#import "DownloadQueueManager.h"
#import "DownloadFile.h"

@interface DownloadQueueManager()




@end

@implementation DownloadQueueManager

+ (DownloadQueueManager *)defaultManager {
    
    static DownloadQueueManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (id)init {
    if (self = [super init]) {
        self.downloadQueue = [[NSOperationQueue alloc] init];
        
        //设置队列数
        self.downloadQueue.maxConcurrentOperationCount = 5;
        
    }
    return self;
}

- (void)addDownloadRequest:(NSString *)reqeustUrl  withDelegate:(id)delegate{
    DownloadFile *downloader = [[DownloadFile alloc]initWithUrl:reqeustUrl];
    downloader.delegate = delegate;
    [self.downloadQueue addOperation:downloader];
}

@end
