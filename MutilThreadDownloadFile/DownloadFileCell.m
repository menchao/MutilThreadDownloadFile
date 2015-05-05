//
//  DownloadFileCell.m
//  MutilThreadDownloadFile
//
//  Created by 门超 on 15/5/5.
//  Copyright (c) 2015年 intel. All rights reserved.
//

#import "DownloadFileCell.h"
#import "DownloadQueueManager.h"
#import "ModelData.h"
#import "DownloadFile.h"

@interface DownloadFileCell()<DownloadFileDelegate>

@property (nonatomic,strong) DownloadQueueManager *downloadQueue;

@property (nonatomic,strong) NSString *fileDescrption;

@end

@implementation DownloadFileCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.downloadProgress setProgress:0.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDownloadQueue:(DownloadQueueManager *)downloadQueue withData:(ModelData *)data
{
    if (self.downloadQueue!=downloadQueue) {
        self.downloadQueue = downloadQueue;
    }
    [downloadQueue addDownloadRequest:data.fileUrl withDelegate:self];
}


- (void)downloadFinishedFilePath:(NSData *)fileData
{
    //NSData *imageData = [NSData dataWithContentsOfFile:filePath.absoluteString];
    self.imageVIew.image = [UIImage imageWithData:fileData];
}



- (void)downloadProgresWithsUrl:(NSString *)fileUrl written:(int64_t)writenBytes toatl:(int64_t)totalBytes
{
    double progress = (float)writenBytes / (float)totalBytes;
    self.precentLbl.text = [NSString stringWithFormat:@"%f",progress*100];
    [self.downloadProgress setProgress:progress];

}




@end
