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
#import "MHSSLWebViewController.h"

@implementation MHRootViewController

- (void)initData{
    
}

- (void)addUI{
    //btn : push to resume download vc
    MHButton *resumeBtn = [MHButton normalButtonWithTitle:@"离线下载"
                                                    frame:CGRectMake(90, 100, 120, 40)
                                                   action:^(MHButton *btn)
    {
        MHResumeViewController *resumeVC = [[MHResumeViewController alloc]init];
        [self.navigationController pushViewController:resumeVC animated:YES];
    }];
    
    //btn : push to download json data vc
    MHButton *downloadJsonBtn = [MHButton normalButtonWithTitle:@"Download Json"
                                                    frame:CGRectMake(90, 180, 120, 40)
                                                   action:^(MHButton *btn)
                           {
                               MHDownloadJsonDataViewController *downloadJsonVC = [[MHDownloadJsonDataViewController alloc]init];
                               [self.navigationController pushViewController:downloadJsonVC animated:YES];
                           }];
    
    //btn : push to SSL web vc
    MHButton *sslWapBtn = [MHButton normalButtonWithTitle:@"SSLWap"
                                                    frame:CGRectMake(90, 260, 120, 40)
                                                   action:^(MHButton *btn)
                           {
                               MHSSLWebViewController *sslWebVC = [[MHSSLWebViewController alloc]init];
                               [self.navigationController pushViewController:sslWebVC animated:YES];
                           }];
    
    [self.view addSubview:resumeBtn];
    [self.view addSubview:downloadJsonBtn];
    [self.view addSubview:sslWapBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end