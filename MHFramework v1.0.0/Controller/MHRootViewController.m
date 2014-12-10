//
//  MHRootViewController.m
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/10.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "MHRootViewController.h"
#import "MHResumeViewController.h"
#import "MHDownloadJsonDataViewController.h"

@implementation MHRootViewController

- (void)initData{
    
}

- (void)addUI{
    //btn : push to resume download vc
    UIButton *resumeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [resumeBtn setTitle:@"离线下载" forState:UIControlStateNormal];
    resumeBtn.backgroundColor = [UIColor grayColor];
    resumeBtn.frame = CGRectMake(110, 100, 80, 40);
    [resumeBtn addTarget:self action:@selector(showResumeDownloadPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resumeBtn];
    
    //btn : push to download json data vc
    UIButton *downloadJsonBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [downloadJsonBtn setTitle:@"Download Json" forState:UIControlStateNormal];
    downloadJsonBtn.backgroundColor = [UIColor grayColor];
    downloadJsonBtn.frame = CGRectMake(90, 180, 120, 40);
    [downloadJsonBtn addTarget:self action:@selector(showDownloadJsonDataPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downloadJsonBtn];
}

- (void)showResumeDownloadPage:(id)sender{
    MHResumeViewController *resumeVC = [[MHResumeViewController alloc]init];
    [self.navigationController pushViewController:resumeVC animated:YES];
}

- (void)showDownloadJsonDataPage:(id)sender{
    MHDownloadJsonDataViewController *downloadJsonVC = [[MHDownloadJsonDataViewController alloc]init];
    [self.navigationController pushViewController:downloadJsonVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end