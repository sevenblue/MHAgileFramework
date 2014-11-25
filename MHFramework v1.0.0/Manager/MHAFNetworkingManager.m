//
//  MHAFNetworkingManager.m
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "MHAFNetworkingManager.h"
#import "AFURLRequestSerialization.h"
#import "AFNetWorking.h"
#import "AFHTTPRequestOperation+TaskInfo.h"
@implementation MHAFNetworkingManager

DEF_SINGLETON(MHAFNetworkingManager)

#pragma mark - post
- (void)postWithUrl:(NSString *)url
              param:(NSDictionary *)parameters
             taskId:(NSString *)taskId
            success:(NetworkSuccessHandler)success
            failure:(NetworkErrorHandler)failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //setHttpHeader
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8"
                     forHTTPHeaderField:@"Content-Type"];
    //设置编码格式
    [manager.responseSerializer setStringEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperation *operation = [manager POST:url parameters:parameters  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
#ifdef BEBUG
         NSException *exception = [NSException
                                   exceptionWithName: @"网络连接错误"
                                   reason:[NSString stringWithFormat:@"error:%@",error]
                                   userInfo: nil];
         @throw exception;
#endif
         failure(error);
     }];
    [operation setTaskId:taskId];
}

#pragma mark - get
- (void)getWithUrl:(NSString *)url
             param:(NSDictionary* )parameters
            taskId:(NSString *)taskId
           success:(NetworkSuccessHandler)success
           failure:(NetworkErrorHandler)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //setHttpHeader
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8"
                     forHTTPHeaderField:@"Content-Type"];
    //设置编码格式
    [manager.responseSerializer setStringEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperation *operation = [manager GET:url parameters:parameters  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
#ifdef BEBUG
         NSException *exception = [NSException
                                   exceptionWithName: @"网络连接错误"
                                   reason:[NSString stringWithFormat:@"error:%@",error]
                                   userInfo: nil];
         @throw exception;
#endif
         failure(error);
     }];
    [operation setTaskId:taskId];
}

#pragma mark - upload data
- (void)uploadDataWithUrl:(NSString *)url
                    param:(NSDictionary*)parameters
                   taskId:(NSString *)taskId
                     data:(NSData *)data
                 dataType:(NSString *)type
                 fileName:(NSString *)fileName
                 progress:(NetworkProgressHandler)progress
                  success:(NetworkSuccessHandler)success
                  failure:(NetworkErrorHandler)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"multipart/form-data"
                     forHTTPHeaderField:@"Content-Type"];

    AFHTTPRequestOperation *operation = [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:fileName fileName:[NSString stringWithFormat:@"%@.%@",fileName,type] mimeType:[NSString stringWithFormat:@"%@/%@",fileName,type]];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
#ifdef BEBUG
        NSException *exception = [NSException
                                  exceptionWithName: @"网络连接错误"
                                  reason:[NSString stringWithFormat:@"error:%@",error]
                                  userInfo: nil];
        @throw exception;
#endif
        failure(error);
    }];
    [operation setTaskId:taskId];
    [operation setUploadProgressBlock:progress];
}
#pragma mark - download data
- (void)downloadDataWithUrl:(NSString *)url
                  localPath:(NSString *)path
                     taskId:(NSString *)taskId
                   progress:(NetworkProgressHandler)progress
                    success:(NetworkSuccessHandler)success
                    failure:(NetworkErrorHandler)failure
{
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0f];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setTaskId:taskId];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:path append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        progress(bytesRead,totalBytesRead,totalBytesExpectedToRead);
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.operationQueue addOperation:operation];
}

- (void)startAllOperationQueue
{
    
}

- (void)pauseQueueWithTaskId:(NSString *)taskId
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    for (AFHTTPRequestOperation*operation in manager.operationQueue.operations) {
        if ([operation.taskId isEqualToString:taskId]) {
            [operation pause];
        }
    }
}

- (void)cancleQueueWithTaskId:(NSString *)taskId
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    for (AFHTTPRequestOperation*operation in manager.operationQueue.operations) {
        if ([operation.taskId isEqualToString:taskId]) {
            [operation pause];
        }
    }
}

- (void)cancleAllOperationQueue
{
    [[AFHTTPRequestOperationManager manager].operationQueue cancelAllOperations];
}



@end
