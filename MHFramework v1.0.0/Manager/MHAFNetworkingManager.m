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
#import "MHDownloadHelper.h"
@implementation MHAFNetworkingManager

DEF_SINGLETON(MHAFNetworkingManager)

#pragma mark - post
- (void)postWithUrl:(NSString *)url
              param:(NSDictionary *)parameters
             taskId:(NSString *)taskId
            success:(NetworkSuccessHandler)success
            failure:(NetworkErrorHandler)failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager sharedInstance];
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
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager sharedInstance];
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
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager sharedInstance];
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
                  localPath:(NSString *)localPath
                   fileName:(NSString *)fileName
                     taskId:(NSString *)taskId
                   progress:(NetworkProgressHandler)progress
                    success:(NetworkSuccessHandler)success
                    failure:(NetworkErrorHandler)failure
{
    [self downloadDataWithUrl:url localPath:localPath fileName:fileName taskId:taskId hasDownloaded:NO progress:progress success:success failure:failure];
}

- (void)downloadDataWithUrl:(NSString *)url
                  localPath:(NSString *)localPath
                   fileName:(NSString *)fileName
                     taskId:(NSString *)taskId
              hasDownloaded:(BOOL)hasDownloaded
                   progress:(NetworkProgressHandler)progress
                    success:(NetworkSuccessHandler)success
                    failure:(NetworkErrorHandler)failure
{
    NSURLRequest *request = [self getURLRequestWithUrl:url localPath:localPath fileName:fileName hasDownloaded:YES];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setTaskId:taskId];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:localPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        progress(bytesRead,totalBytesRead,totalBytesExpectedToRead);
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager sharedInstance];
    [manager.operationQueue addOperation:operation];
}

//private
- (NSURLRequest *)getURLRequestWithUrl:(NSString *)url
                             localPath:(NSString *)localPath
                              fileName:(NSString *)fileName
                         hasDownloaded:(BOOL)hasDownloaded
{
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0f];
    if (hasDownloaded) {
        NSString *downloadPath = [localPath stringByAppendingPathComponent:fileName];
        //检查文件是否已经下载了一部分
        unsigned long long downloadedBytes = 0;
        if ([[NSFileManager defaultManager] fileExistsAtPath:downloadPath]) {
            downloadedBytes = [MHDownloadHelper fileSizeForPath:downloadPath];
            if (downloadedBytes > 0) {
                NSMutableURLRequest *mutableURLRequest = [request mutableCopy];
                NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
                [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
                request = mutableURLRequest;
            }
        }
        [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    }
    return request;
}

#pragma mark -
- (void)startAllOperationQueue
{
    
}

- (void)pauseQueueWithTaskId:(NSString *)taskId
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager sharedInstance];
    for (AFHTTPRequestOperation*operation in manager.operationQueue.operations) {
        if ([operation.taskId isEqualToString:taskId]) {
            [operation pause];
        }
    }
}

- (void)cancleQueueWithTaskId:(NSString *)taskId
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager sharedInstance];
    for (AFHTTPRequestOperation*operation in manager.operationQueue.operations) {
        NSLog(@"%@",operation.taskId);
        if ([operation.taskId isEqualToString:taskId]) {
            [operation cancel];
        }
    }
}

- (void)cancleAllOperationQueue
{
    [[AFHTTPRequestOperationManager manager].operationQueue cancelAllOperations];
}



@end
