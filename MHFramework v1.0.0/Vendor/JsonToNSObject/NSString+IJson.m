//
// Created by cai on 13-1-6.
//
//


#import "NSString+IJson.h"
#import "JSONKit.h"
#import "BaseNSObject.h"
@implementation NSString (IJson)

- (NSObject *)jsonStringToNSObjectWithKey:(NSString *)aKey andClass:(Class)aClass;
{
    NSArray *objects = [self jsonStringToNSObjectsWithKey:aKey andClass:aClass];
    return (1 == objects.count) ? objects.lastObject : nil;
}

- (NSArray *)jsonStringToNSObjectsWithKey:(NSString *)aKey andClass:(Class)aClass;
{
    if (nil == aClass)
    {
        return nil;
    }
    
    id rootJsonObj = nil;
    if (nil == aKey || 0 == [aKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length)
    {
        rootJsonObj = [self objectFromJSONString];
    }
    else
    {
        rootJsonObj = [[self objectFromJSONString] objectForKey:aKey];
    }
    
    NSDictionary *keyDict = [aClass keyDict];
    
    if ([rootJsonObj isKindOfClass:[NSArray class]])
    {
        int a = [(NSArray *)rootJsonObj count];
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
    else if ([rootJsonObj isKindOfClass:[NSDictionary class]])
    {
        id object = [[aClass alloc] init];
        [rootJsonObj enumerateKeysAndObjectsUsingBlock:^(id key,id obj,BOOL *stop)
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
        return object;
    }
    return nil;
}

@end