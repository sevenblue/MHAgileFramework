//
//  MHDownloadJsonDataViewController.m
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/10.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "MHDownloadJsonDataViewController.h"
#import "MHJsonDataSource.h"
#import "MHJsonModel.h"
#import "MHFMDBManager.h"

@implementation MHDownloadJsonDataViewController

- (void)initData{
    
}

- (void)addUI{
    [self setTitle:@"Json下载"];
    
    //btn : push to download json data vc
    UIButton *downloadJsonBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [downloadJsonBtn setTitle:@"Download" forState:UIControlStateNormal];
    downloadJsonBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    downloadJsonBtn.backgroundColor = [UIColor grayColor];
    downloadJsonBtn.frame = CGRectMake(90, 180, 120, 40);
    [downloadJsonBtn addTarget:self action:@selector(downLoadJson:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downloadJsonBtn];
}

- (void)downLoadJson:(id)sender{
    [[MHAFNetworkingManager sharedInstance]postWithUrl:ACTION_EXAMPLE_JSON param:nil taskId:ACTION_EXAMPLE_JSON success:^(id responseObject) {
        if (responseObject) {
            if ([[responseObject class] isSubclassOfClass:[NSArray class]]) {
                if ([responseObject count]) {
                    /*  eg.返回单个model
                    for (id obj in responseObject) {
                        id model = [MHJsonDataSource jsonDataToNSObjectWithResponseObject:obj andClass:[MHJsonModel class]];
                        NSLog(@"%@",model);
                    }
                     */
                    /*  eg.返回model list  */
                    NSArray * modelList = [MHJsonDataSource jsonDataToNSObjectsWithResponseObject:responseObject andClass:[MHJsonModel class]];
                    NSLog(@"%@",modelList);
                    
                    /*  save to DB  */
                    NSArray *arr = @[@"aaa",@"bbbb",@"cccc"];
                    [[MHFMDBManager sharedInstance]insertToDBWithModelList:arr inDB:@"globle_tables"];
                }
                
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}

@end
