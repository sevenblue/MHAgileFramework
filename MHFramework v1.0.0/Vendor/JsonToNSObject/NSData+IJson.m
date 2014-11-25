//
// Created by cai on 13-1-6.
//
//


#import "NSData+IJson.h"
#import "JSONKit.h"
#import "NSString+IJson.h"
#import "BaseNSObject.h"


@implementation NSData (IJson)

- (NSObject *)jsonDataToNSObjectWithKey:(NSString *)aKey andClass:(Class)aClass;
{
    NSArray *objects = [self jsonDataToNSObjectsWithKey:aKey andClass:aClass];
    return (1 == objects.count) ? objects.lastObject : nil;
}

- (NSArray *)jsonDataToNSObjectsWithKey:(NSString *)aKey andClass:(Class)aClass;
{
    if (nil == aClass)
    {
        return nil;
    }

    id rootJsonObj = nil;
    if (nil == aKey || 0 == [aKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length)
    {
        rootJsonObj = [self objectFromJSONData];
    }
    else
    {
        rootJsonObj = [[self objectFromJSONData] objectForKey:aKey];
    }

    NSDictionary *keyDict = [aClass keyDict];

    if ([rootJsonObj isKindOfClass:[NSArray class]])
    {
        NSMutableArray *objects = [NSMutableArray arrayWithCapacity:[(NSArray *)rootJsonObj count]];
        for (NSDictionary *dict in rootJsonObj)
        {
            id object = [[aClass alloc] init];
            [dict enumerateKeysAndObjectsUsingBlock:^(id key,id obj,BOOL *stop)
            {
                if ([obj isKindOfClass:[NSArray class]])
                {
                    NSArray *array = [[obj JSONData] jsonDataToNSObjectsWithKey:nil andClass:NSClassFromString([keyDict valueForKey:key])];
                    [object setValue:array forKey:key];
                }
                else if([obj isKindOfClass:[NSDictionary class]])
                {
                    id otherObjct = [[obj JSONData] jsonDataToNSObjectsWithKey:nil andClass:NSClassFromString([keyDict valueForKey:key])];
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
                NSArray *array = [[obj JSONData] jsonDataToNSObjectsWithKey:nil andClass:NSClassFromString([keyDict valueForKey:key])];
                [object setValue:array forKey:key];
            }
            else if([obj isKindOfClass:[NSDictionary class]])
            {
                id otherObjct = [[obj JSONData] jsonDataToNSObjectsWithKey:nil andClass:NSClassFromString([keyDict valueForKey:key])];
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