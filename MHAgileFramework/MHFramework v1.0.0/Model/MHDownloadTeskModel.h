//
//  MHDownloadTeskModel.h
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/11/25.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^NetworkSuccessHandler)(id responseObject);
typedef void(^NetworkErrorHandler)(NSError *error);
typedef void(^NetworkProgressHandler)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);

@interface MHDownloadTeskModel : NSObject

@property (nonatomic, copy) NSString *taskId;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSDictionary *pramaters;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, assign) NetworkProgressHandler progressBlock;
@property (nonatomic, assign) NetworkSuccessHandler successBlock;
@property (nonatomic, assign) NetworkErrorHandler failureBlock;

@end
