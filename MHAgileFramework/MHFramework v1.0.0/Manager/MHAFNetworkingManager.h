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
 *  Upload data interface
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
 *  Download data with progress
 */
- (void)downloadDataWithUrl:(NSString *)url
                  localPath:(NSString *)localPath
                   fileName:(NSString *)fileName
                     taskId:(NSString *)taskId
                   progress:(NetworkProgressHandler)progress
                    success:(NetworkSuccessHandler)success
                    failure:(NetworkErrorHandler)failure;

/**
 *  Used for reload data which the app hasn't finished download at last time.
 *
 *  @param taskId   to identify the diffierence of every download operation
 *  @param size     file had been downloaded size
 */
- (void)downloadDataWithUrl:(NSString *)url
                  localPath:(NSString *)localPath
                   fileName:(NSString *)fileName
                     taskId:(NSString *)taskId
              hasDownloaded:(BOOL)hasDownloaded
                   progress:(NetworkProgressHandler)progress
                    success:(NetworkSuccessHandler)success
                    failure:(NetworkErrorHandler)failure;

- (void)startQueueWithTaskId:(NSString *)taskId;
- (void)pauseQueueWithTaskId:(NSString *)taskId;
- (void)cancleQueueWithTaskId:(NSString *)taskId;
- (void)cancleAllOperationQueue;

@end
