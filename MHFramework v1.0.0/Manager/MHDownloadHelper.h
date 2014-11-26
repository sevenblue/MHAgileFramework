//
//  MHDownloadHelper.h
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/11/26.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHDownloadHelper : NSObject

/**
 *  Get file size
 *  @param path filePath
 *  @return Returns the value for the key NSFileSize.
 */
+ (unsigned long long)fileSizeForPath:(NSString *)path;

@end
