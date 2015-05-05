//
//  ViewController.m
//  MutilThreadDownloadFile
//
//  Created by 门超 on 15/5/5.
//  Copyright (c) 2015年 intel. All rights reserved.
//

#import "ViewController.h"
#import "DownloadFileCell.h"
#import "ModelData.h"
#import "DownloadFile.h"
#import "DownloadQueueManager.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong) NSMutableArray *downloadMArray;

@property (nonatomic,strong)DownloadQueueManager *downloadQueueManager;

@end




#define FIlE_NUMBER 6

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.downloadMArray  = [[NSMutableArray alloc]init];
    self.downloadQueueManager = [DownloadQueueManager defaultManager];
    
     NSMutableArray *fileUrlMArray = [[NSMutableArray alloc]init];
     [fileUrlMArray addObject: @"https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/TransitionGuide/TransitionGuide.pdf"];
    [fileUrlMArray addObject:@"http://h.hiphotos.baidu.com/image/w%3D310/sign=fdc8852ebc096b63811958513c328733/ac345982b2b7d0a2fb7a469cc9ef76094b369a04.jpg"];
    [fileUrlMArray addObject:@"http://a.hiphotos.baidu.com/image/w%3D310/sign=56edbda2ae6eddc426e7b2fa09dbb6a2/42a98226cffc1e17d29b1f764990f603738de955.jpg"];
    [fileUrlMArray addObject:@"http://d.hiphotos.baidu.com/album/w%3D1920%3Bcrop%3D0%2C0%2C1920%2C1080/sign=385b11bb0823dd542173a361e33988bd/0d338744ebf81a4ca2478116d62a6059242da6fc.jpg"];
    [fileUrlMArray addObject:@"http://g.hiphotos.baidu.com/album/w%3D1920%3Bcrop%3D0%2C0%2C1920%2C1080/sign=672b402137d3d539c13d0bca08b7d233/1f178a82b9014a9058c22662a8773912b21bee75.jpg"];
    [fileUrlMArray addObject:@"http://a.hiphotos.baidu.com/album/w%3D1920%3Bcrop%3D0%2C0%2C1920%2C1080/sign=ac77d8ff00e939015602893749dc6f84/7af40ad162d9f2d387824430a8ec8a136227cc5a.jpg"];
    [fileUrlMArray addObject:@"http://h.hiphotos.baidu.com/image/w%3D400/sign=2d597c2eb27eca80120538e7a1239712/cf1b9d16fdfaaf516c965bb28e5494eef01f7a42.jpg"];

    for (int i= 0; i<[fileUrlMArray count]; i++) {
        ModelData *data = [ModelData new];
        data.fileUrl = [fileUrlMArray objectAtIndex:i];
        data.fileDescrption = [data.fileUrl lastPathComponent];
        [self.downloadMArray addObject:data];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.downloadMArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DownloadFileCell";
    DownloadFileCell *cell = (DownloadFileCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    ModelData *data = [self.downloadMArray objectAtIndex:[indexPath row]];
    if (data) {
        //cell.descptionLbl.text = data.fileDescrption;
        [cell setDownloadQueue:self.downloadQueueManager withData:data];
    }
    return cell;
}


@end
