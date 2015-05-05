//
//  DownloadFileCell.h
//  MutilThreadDownloadFile
//
//  Created by 门超 on 15/5/5.
//  Copyright (c) 2015年 intel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadQueueManager.h"
#import "ModelData.h"

@interface DownloadFileCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;


@property (weak, nonatomic) IBOutlet UILabel *precentLbl;


@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgress;


- (void)setDownloadQueue:(DownloadQueueManager *)downloadQueue withData:(ModelData *)data;

@end
