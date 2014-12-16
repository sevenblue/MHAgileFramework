//
//  MHJsonDataSource.h
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/11.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  json解析类，利用runtime动态解析jason数据并且返回自定义数据对象集合
 */
@interface MHJsonDataSource : NSObject

+ (NSArray *)jsonDataToNSObjectsWithResponseObject:(id)obj andClass:(Class)aClass;

+ (NSObject *)jsonDataToNSObjectWithResponseObject:(id)obj andClass:(Class)aClass;

@end
