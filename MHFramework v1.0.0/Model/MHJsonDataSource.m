//
//  MHJsonDataSource.m
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/11.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "MHJsonDataSource.h"
#import "NSArray+MHJson.h"
#import "NSDictionary+MHJson.h"

@implementation MHJsonDataSource

+ (NSArray *)jsonDataToNSObjectsWithResponseObject:(id)obj andClass:(Class)aClass
{
    if ([[obj class] isSubclassOfClass:[NSArray class]]) {
        return [self jsonDataToNSObjectsWithArray:obj andClass:aClass];
    }else if([[obj class] isSubclassOfClass:[NSDictionary class]]){
        return [self jsonDataToNSObjectsWithDictionary:obj andClass:aClass];
    }
    return nil;
}

+ (NSObject *)jsonDataToNSObjectWithResponseObject:(id)obj andClass:(Class)aClass
{
    if ([[obj class] isSubclassOfClass:[NSArray class]]) {
        return [self jsonDataToNSObjectWithArray:obj andClass:aClass];
    }else if([[obj class] isSubclassOfClass:[NSDictionary class]]){
        return [self jsonDataToNSObjectWithDictionary:obj andClass:aClass];
    }
    return nil;
}

#pragma mark - private
+ (NSArray *)jsonDataToNSObjectsWithArray:(NSArray *)arr andClass:(Class)aClass
{
    return [arr  jsonDataToNSObjectsClass:aClass];
}

+ (NSObject *)jsonDataToNSObjectWithArray:(NSArray *)arr andClass:(Class)aClass
{
    return [arr jsonDataToNSObjectClass:aClass];
}

+ (NSArray *)jsonDataToNSObjectsWithDictionary:(NSDictionary *)dic andClass:(Class)aClass
{
    return [dic jsonDataToNSObjectsClass:aClass];
}

+ (NSObject *)jsonDataToNSObjectWithDictionary:(NSDictionary *)dic andClass:(Class)aClass
{
    return [dic jsonDataToNSObjectClass:aClass];
}

@end
