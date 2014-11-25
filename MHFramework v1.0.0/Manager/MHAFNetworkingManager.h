//
//  MHAFNetworkingManager.h
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetworkSuccessHandler)(id responseObject,NSDictionary *resquestParam);
typedef void(^NetworkErrorHandler)(NSError *error);
typedef void(^NetworkProgressHandler)(float progress);

@interface MHAFNetworkingManager : NSObject

AS_SINGLETON(MHAFNetworkingManager)

- (void)postWithUrl:(NSString *)url
              param:(NSDictionary *)parameters
            success:(NetworkSuccessHandler)success
            failure:(NetworkErrorHandler)failure;

- (void)getWithUrl:(NSString *)url
             param:(NSDictionary* )parameters
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
                     data:(NSData *)data
                 dataType:(NSString *)type
                 fileName:(NSString *)fileName
                 progress:(void(^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
                  success:(NetworkSuccessHandler)success
                  failure:(NetworkErrorHandler)failure;

/**
 *  download data with progress
 */
- (void)downloadDataWithUrl:(NSString *)url
                  localPath:(NSString *)path
                   progress:(void (^)(long long totalBytesRead, long long totalBytesExpectedToRead))progress
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;

- (void)saveAllOperationQueue;
- (void)startAllOperationQueue;

- (void)pauseQueueWithTaskId:(NSString *)taskId;

- (void)cancleAllOperationQueue;
- (void)cancleQueueWithTeskId:(NSString *)teskId;

@end
