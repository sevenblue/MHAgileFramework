//
//  MHDownloadHelper.m
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/11/26.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "MHDownloadHelper.h"

@implementation MHDownloadHelper

+ (unsigned long long)fileSizeForPath:(NSString *)path
{
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}



@end
