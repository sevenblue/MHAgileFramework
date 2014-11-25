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
@implementation MHAFNetworkingManager

DEF_SINGLETON(MHAFNetworkingManager)

#pragma mark - post
- (void)postWithUrl:(NSString *)url
              param:(NSDictionary *)parameters
            success:(NetworkSuccessHandler)success
            failure:(NetworkErrorHandler)failure;
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //setHttpHeader
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8"
                     forHTTPHeaderField:@"Content-Type"];
    //设置编码格式
    [manager.responseSerializer setStringEncoding:NSUTF8StringEncoding];
    [manager POST:url parameters:parameters  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject,parameters);
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
}

#pragma mark - get
- (void)getWithUrl:(NSString *)url
             param:(NSDictionary* )parameters
           success:(NetworkSuccessHandler)success
           failure:(NetworkErrorHandler)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //setHttpHeader
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8"
                     forHTTPHeaderField:@"Content-Type"];
    //设置编码格式
    [manager.responseSerializer setStringEncoding:NSUTF8StringEncoding];
    [manager GET:url parameters:parameters  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject,parameters);
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
}

#pragma mark - upload data
- (void)uploadDataWithUrl:(NSString *)url
                    param:(NSDictionary*)parameters
                     data:(NSData *)data
                 dataType:(NSString *)type
                 fileName:(NSString *)fileName
                 progress:(void(^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
                  success:(NetworkSuccessHandler)success
                  failure:(NetworkErrorHandler)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"multipart/form-data"
                     forHTTPHeaderField:@"Content-Type"];

    AFHTTPRequestOperation *operation = [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:fileName fileName:[NSString stringWithFormat:@"%@.%@",fileName,type] mimeType:[NSString stringWithFormat:@"%@/%@",fileName,type]];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject,parameters);
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
    [operation setUploadProgressBlock:progress];
}
#pragma mark - download data
- (void)downloadDataWithUrl:(NSString *)url
                  localPath:(NSString *)path
                   progress:(void (^)(long long totalBytesRead, long long totalBytesExpectedToRead))progress
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure
{
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0f];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setOutputStream:[NSOutputStream outputStreamToFileAtPath:path append:NO]];
    [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        progress(totalBytesRead,totalBytesExpectedToRead);
    }];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.operationQueue addOperation:op];
}

- (void)saveAllOperationQueue
{
    
}
- (void)startAllOperationQueue
{
    
}

- (void)pauseQueueWithTaskId:(NSString *)taskId
{
    
}

- (void)cancleAllOperationQueue
{
    [[AFHTTPRequestOperationManager manager].operationQueue cancelAllOperations];
}

- (void)cancleQueueWithTeskId:(NSString *)teskId
{
    [AFHTTPRequestOperationManager manager].operationQueue
}

@end
