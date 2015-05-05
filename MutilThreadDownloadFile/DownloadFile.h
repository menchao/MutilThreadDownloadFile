//
//  DownloadFile.h
//  InterEdu
//
//  Created by 门超 on 15/3/4.
//  Copyright (c) 2015年 inter. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void (^DowloadFinishedBlock)(NSData* fileData);
//typedef void (^DowloadFinishedFileBlock)(NSString* filePath);



@protocol DownloadFileDelegate <NSObject>
@optional
- (void)downloadFinishedFilePath:(NSData *)fileData;
- (void)downloadProgresWithsUrl:(NSString *)fileUrl written:(int64_t)writenBytes toatl:(int64_t)totalBytes;

@end


@interface DownloadFile : NSOperation

@property (nonatomic,assign) id<DownloadFileDelegate>delegate;

- (instancetype)initWithUrl:(NSString *)fileUrl;

@end
