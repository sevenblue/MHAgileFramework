//
//  MHAFNetworkingManager.h
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef void(^NetworkSuccessHandler)(id responseObject);
typedef void(^NetworkErrorHandler)(NSError *error);
typedef void(^NetworkProgressHandler)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);

@interface MHAFNetworkingManager : NSObject

AS_SINGLETON(MHAFNetworkingManager)

- (void)postWithUrl:(NSString *)url
              param:(NSDictionary *)parameters
             taskId:(NSString *)taskId
            success:(NetworkSuccessHandler)success
            failure:(NetworkErrorHandler)failure;

- (void)getWithUrl:(NSString *)url
             param:(NSDictionary* )parameters
            taskId:(NSString *)taskId
           success:(NetworkSuccessHandler)success
           failure:(NetworkErrorHandler)failure;

/**
 *  upload data interface
 *
 *  @param data       the data needed to upload
 *  @param type       the data type,eg.png/jepg/amr/...
 *  @param fileName   the name of file
 *  @param progress   upload progress
 *  @param success    success block
 *  @param failure    failure block
 */
- (void)uploadDataWithUrl:(NSString *)url
                    param:(NSDictionary*)parameters
                   taskId:(NSString *)taskId
                     data:(NSData *)data
                 dataType:(NSString *)type
                 fileName:(NSString *)fileName
                 progress:(void(^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
                  success:(NetworkSuccessHandler)success
                  failure:(NetworkErrorHandler)failure;

/**
 *  download data with progress
 *  @return MHDownloadTeskModel file in all needed download tesk info
 */
- (void)downloadDataWithUrl:(NSString *)url
                  localPath:(NSString *)path
                     taskId:(NSString *)taskId
                   progress:(NetworkProgressHandler)progress
                    success:(NetworkSuccessHandler)success
                    failure:(NetworkErrorHandler)failure;

- (void)pauseQueueWithTaskId:(NSString *)taskId;
- (void)cancleQueueWithTaskId:(NSString *)taskId;
- (void)cancleAllOperationQueue;

@end
