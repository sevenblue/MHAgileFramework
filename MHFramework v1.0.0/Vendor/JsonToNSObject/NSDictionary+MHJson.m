//
//  NSDictionary+MHJson.m
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/12.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "NSDictionary+MHJson.h"
#import "JSONKit.h"
#import "BaseNSObject.h"
#import "NSString+IJson.h"

@implementation NSDictionary (MHJson)

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
    
    if ([rootJsonObj isKindOfClass:[NSDictionary class]])
    {
        id object = [[aClass alloc] init];
        [rootJsonObj enumerateKeysAndObjectsUsingBlock:^(id key,id obj,BOOL *stop)
         {
             if ([obj isKindOfClass:[NSArray class]])
             {
                 NSArray *array = [self jsonDataToNSObjectsClass:NSClassFromString([keyDict valueForKey:key])];
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
        return object;
    }
    return nil;
}
    
@end

