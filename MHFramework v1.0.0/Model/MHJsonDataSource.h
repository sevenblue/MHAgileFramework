//
//  MHJsonDataSource.h
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/11.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHJsonDataSource : NSObject

+ (NSArray *)factoryWithResponseData:(id)responseObj andClass:(Class)cls;

@end
