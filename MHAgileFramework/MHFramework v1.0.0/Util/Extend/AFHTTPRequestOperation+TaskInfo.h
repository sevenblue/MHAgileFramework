//
//  AFHTTPRequestOperation+TaskInfo.h
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/11/25.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

/**
 *  Extention,add some necessary properties (which can record the tesk operation info)
    to the AFHTTPRequestOperation class
 */
@interface AFHTTPRequestOperation (TaskInfo)

- (NSString *)taskId;
- (NSString *)url;
- (NSDictionary *)pramaters;
- (NSString *)filePath;
- (NSString *)fileName;

- (void)setTaskId:(NSString *)taskId;
- (void)setPramaters:(NSDictionary *)pramaters;
- (void)setFilePath:(NSString *)filePath;
- (void)setFileName:(NSString *)fileName;

@end
