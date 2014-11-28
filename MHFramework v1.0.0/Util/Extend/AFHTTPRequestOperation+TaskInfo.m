//
//  AFHTTPRequestOperation+TaskInfo.m
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/11/25.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "AFHTTPRequestOperation+TaskInfo.h"
#import <objc/runtime.h>
@implementation AFHTTPRequestOperation (TaskInfo)

#define KEY_TASKINFO_TESKID     @"KEY_TASKINFO_TESKID"
#define KEY_TASKINFO_URL        @"KEY_TASKINFO_URL"
#define KEY_TASKINFO_PRAMATERS  @"KEY_TASKINFO_PRAMATERS"
#define KEY_TASKINFO_FILEPATH   @"KEY_TASKINFO_FILEPATH"
#define KEY_TASKINFO_FILENAME   @"KEY_TASKINFO_FILENAME"

#pragma mark - getter
- (NSString *)taskId{
    return objc_getAssociatedObject(self, KEY_TASKINFO_TESKID);
}

- (NSString *)url{
    return [self.request.URL absoluteString];
}

- (NSDictionary *)pramaters{
    return objc_getAssociatedObject(self, KEY_TASKINFO_PRAMATERS);
}

- (NSString *)filePath{
    return objc_getAssociatedObject(self, KEY_TASKINFO_FILEPATH);
}

- (NSString *)fileName{
    return objc_getAssociatedObject(self, KEY_TASKINFO_FILENAME);
}

#pragma mark - setter
- (void)setTaskId:(NSString *)taskId{
    objc_setAssociatedObject(self, KEY_TASKINFO_TESKID, taskId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPramaters:(NSDictionary *)pramaters{
    objc_setAssociatedObject(self, KEY_TASKINFO_PRAMATERS, pramaters, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setFilePath:(NSString *)filePath{
    objc_setAssociatedObject(self, KEY_TASKINFO_FILEPATH, filePath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setFileName:(NSString *)fileName{
    objc_setAssociatedObject(self, KEY_TASKINFO_FILENAME, fileName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
