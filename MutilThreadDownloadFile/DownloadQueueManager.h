//
//  DownloadQueueManager.h
//  MutilThreadDownloadFile
//
//  Created by 门超 on 15/5/5.
//  Copyright (c) 2015年 intel. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  下载队列管理
 */
@interface DownloadQueueManager : NSObject


+ (DownloadQueueManager *)defaultManager;

- (void)addDownloadRequest:(NSString *)reqeustUrl  withDelegate:(id)delegate;

@property (nonatomic,strong) NSOperationQueue *downloadQueue;

@end
