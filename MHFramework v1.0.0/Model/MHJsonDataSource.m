//
//  MHJsonDataSource.m
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/11.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "MHJsonDataSource.h"
#import "NSString+IJson.h"

@implementation MHJsonDataSource

+ (NSArray *)factoryWithResponseData:(id)responseObj andClass:(Class)cls{
    return [responseObj jsonStringToNSObjectsWithKey:nil andClass:cls];
}

@end
