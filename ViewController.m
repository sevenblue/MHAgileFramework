//
//  ViewController.m
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/11/19.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "ViewController.h"
#import "SandboxFile.h"

#define KEY_TASKID_MP3  @"KEY_TASKID_MP3"
@interface ViewController ()
{
    UIProgressView *_progressV;
    UILabel *_progressLabel;
    BOOL _downloaded;
    BOOL _firstDownloaded;
    
    //模拟离线下载
    float _currentSize;
    float _totalSize;
    float _reCurrentSize;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initData];
    
    [self addUI];
}

- (void)initData{
    //initilize data
    _downloaded = NO;
    _firstDownloaded = YES;
}

- (void)addUI{
    //progress label
    _progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 50, 80, 20)];
    _progressLabel.textAlignment = NSTextAlignmentCenter;
    _progressLabel.text = @"0%";
    [self.view addSubview:_progressLabel];
    
    //progress view
    _progressV = [[UIProgressView alloc]initWithFrame:CGRectMake(10, 100, 300, 20)];
    [self.view addSubview:_progressV];
    
    //begin & pause btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"第一次下载" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor grayColor];
    btn.frame = CGRectMake(110, 200, 80, 40);
    [btn addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)downloadAction:(UIButton *)btn
{
    if(!_downloaded && _firstDownloaded){           //第一次下载
        _downloaded = YES;
        _firstDownloaded = NO;
        [btn setTitle:@"停止下载" forState:UIControlStateNormal];

        __block UIProgressView *progressV = _progressV;
        __block UILabel *progressLabel = _progressLabel;
        
        //eg.1 download data
        NSString *filePath = [self getDownloadFilePath:@"downloadMP3"];
        NSLog(@"filePath：%@",filePath);
        
        [[MHAFNetworkingManager sharedInstance]downloadDataWithUrl:ACTION_EXAMPLE_MP3 localPath:filePath fileName:@"apple.mp3" taskId:KEY_TASKID_MP3 progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            
            if (totalBytesWritten == totalBytesExpectedToWrite) {
                return ;
            }
            
            _currentSize = totalBytesWritten/1024.f;
            _totalSize = totalBytesExpectedToWrite/1024.f;
            NSLog(@"progress%lld——%lld",totalBytesWritten,totalBytesExpectedToWrite);
            NSString *proStr = [[NSString stringWithFormat:@"%.0f",(_currentSize/_totalSize)*100]stringByAppendingString:@"%"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                progressLabel.text = proStr;
                progressV.progress = _currentSize/_totalSize;
            });
        } success:^(id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                progressLabel.text = @"100%";
                progressV.progress = 1;
            });
        } failure:^(NSError *error) {
            NSLog(@"error:%@",error);
        }];
    }
    else if (_downloaded && !_firstDownloaded){         //第一次暂停
        _downloaded = NO;
        [btn setTitle:@"断点续传" forState:UIControlStateNormal];
        
        [[MHAFNetworkingManager sharedInstance]cancleQueueWithTaskId:KEY_TASKID_MP3];
    }
    else if (!_downloaded && !_firstDownloaded){        //暂停以后离线下载
        _downloaded = YES;
        [btn setTitle:@"停止下载" forState:UIControlStateNormal];

        __block UIProgressView *progressV = _progressV;
        __block UILabel *progressLabel = _progressLabel;
        
        [[MHAFNetworkingManager sharedInstance]downloadDataWithUrl:ACTION_EXAMPLE_MP3 localPath:[self getDownloadFilePath:@"downloadMP3"] fileName:@"apple.mp3" taskId:KEY_TASKID_MP3 hasDownloaded:YES progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            
            float currentSize;
            if (_reCurrentSize) {
                currentSize = totalBytesWritten/1024.f + _reCurrentSize;
            }else{
                float currentSize = totalBytesWritten/1024.f + _currentSize;
                _reCurrentSize = currentSize;
            }
            
            float totalSize = _totalSize;
            NSLog(@"progress%.0f——%.0f",currentSize*1024.0f,totalSize*1024.0f);
            NSString *proStr = [[NSString stringWithFormat:@"%.0f",(currentSize/totalSize)*100]stringByAppendingString:@"%"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                progressLabel.text = proStr;
                progressV.progress = currentSize/totalSize;
            });
        } success:^(id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                progressLabel.text = @"100%";
                progressV.progress = 1;
                [btn setTitle:@"下载完成" forState:UIControlStateNormal];
                btn.enabled = NO;
            });
        } failure:^(NSError *error) {
            NSLog(@"error:%@",error);
        }];
    }
}

//helper
- (NSString*)getDownloadFilePath:(NSString *)name {
    NSString *filePath = [[SandboxFile GetDocumentPath] stringByAppendingPathComponent:name];
    // Remove the filename and create the remaining path
    [[NSFileManager defaultManager] createDirectoryAtPath:[filePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
    
    return filePath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
