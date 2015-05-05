//
//  DownloadFile.m
//  InterEdu
//
//  Created by 门超 on 15/3/4.
//  Copyright (c) 2015年 inter. All rights reserved.
//

#import "DownloadFile.h"
#import "AFURLSessionManager.h"

@interface DownloadFile()
{
    BOOL isFinished;
}
@property (nonatomic,copy) NSString *fileUrl;
@property (nonatomic,strong) AFURLSessionManager *afUrlSessionManager;
@property (nonatomic,strong) NSURLSessionDownloadTask *urlSessionDownloadTask;

@end

@implementation DownloadFile

-  (NSURLSessionConfiguration *)defaultSessionConfig
{
    NSURLSessionConfiguration *sessionConfig = nil;
    sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.timeoutIntervalForRequest = 20;
    sessionConfig.networkServiceType = NSURLNetworkServiceTypeDefault;
    return sessionConfig;
}

- (instancetype)initWithUrl:(NSString *)fileUrl
{
    self = [super init];
    if(self)
    {
        self.fileUrl = fileUrl;
    }
    return self;
}

- (void)main {
    isFinished = NO;
    [self startDownload1];
}

- (void)startDownload1
{
    self.afUrlSessionManager =  [[AFURLSessionManager alloc]initWithSessionConfiguration:[self defaultSessionConfig]];
    NSURL * nsURL = [NSURL URLWithString:self.fileUrl];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:nsURL];
    self.urlSessionDownloadTask =   [self.afUrlSessionManager downloadTaskWithRequest:request
                                                                             progress:nil
                                                                          destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                                                              
                                                                              NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                                                                              
                                                                              
                                                                              NSURL *finalURL = [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
                                                                              NSLog(@"finalURL:%@",[finalURL lastPathComponent]);
                                                                              
                                                                              return finalURL;
                                                                              
                                                                          }
                                                                    completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                                                        isFinished = YES;
                                                                        if (self.delegate && [self.delegate respondsToSelector:@selector(downloadFinishedFilePath:)]) {
                                                                            
                                                                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                                                
                                                                                NSData *imageData = [NSData dataWithContentsOfURL:filePath];
                                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                                      [self.delegate downloadFinishedFilePath:imageData];
                                                                                });
                                                                            });
                                                                            
                                                                            
                                                                        }
                                                                        NSLog(@"filePath:%@",filePath);
                                                                    }];
    [self.urlSessionDownloadTask resume];
    
    __weak typeof(self) weakSelf = self;
     [self.afUrlSessionManager setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
          
         if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(downloadProgresWithsUrl:written:toatl:)]) {
             
             
             dispatch_async(dispatch_get_main_queue(), ^{
                          [weakSelf.delegate downloadProgresWithsUrl:weakSelf.fileUrl written:totalBytesWritten toatl:totalBytesExpectedToWrite];
             });
             
    
             
         }
    }];
    
    
    while (!isFinished) {
        
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
    }
}


@end
