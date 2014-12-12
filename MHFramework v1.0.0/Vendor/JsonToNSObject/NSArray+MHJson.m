//
//  NSArray+MHJson.m
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/12.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "NSArray+MHJson.h"
#import "JSONKit.h"
#import "NSString+IJson.h"
#import "BaseNSObject.h"

@implementation NSArray (MHJson)

- (NSObject *)jsonDataToNSObjectClass:(Class)aClass
{
    id obj = [self jsonDataToNSObjectsClass:aClass];
    if ([[obj class]isSubclassOfClass:[NSArray class]]) {
        return (1 == [((NSArray *)obj) count]) ? [((NSArray *)obj) lastObject] : nil;
    }else if([[obj class]isSubclassOfClass:aClass]){
        return obj;
    }
    return nil;
}

- (id)jsonDataToNSObjectsClass:(Class)aClass
{
    if (nil == aClass)
    {
        return nil;
    }
    
    id rootJsonObj = self;
    
    NSDictionary *keyDict = [aClass keyDict];
    
    if ([rootJsonObj isKindOfClass:[NSArray class]])
    {
        int a = (int)[(NSArray *)rootJsonObj count];
        NSMutableArray    *objects = [NSMutableArray arrayWithCapacity:a];
        for (NSDictionary *dict in rootJsonObj)
        {
            id object = [[aClass alloc] init];
            [dict enumerateKeysAndObjectsUsingBlock:^(id key,id obj,BOOL *stop)
             {
                 if ([obj isKindOfClass:[NSArray class]])
                 {
                     NSArray *array = [[obj JSONString] jsonStringToNSObjectsWithKey:nil andClass:NSClassFromString([keyDict valueForKey:key])];
                     [object setValue:array forKey:key];
                 }
                 else if([obj isKindOfClass:[NSDictionary class]])
                 {
                     id otherObjct = [[obj JSONString] jsonStringToNSObjectsWithKey:nil andClass:NSClassFromString([keyDict valueForKey:key])];
                     [object setValue:otherObjct forKey:key];
                 }
                 else
                 {
                     [object setValue:obj forKey:[keyDict valueForKey:key]];
                 }
                 
             }];
            [objects addObject:object];
        }
        return objects;
    }
    return nil;
}

@end


