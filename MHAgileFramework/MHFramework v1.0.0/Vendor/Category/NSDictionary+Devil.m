//
//  NSDictionary+Devil.m
//  13Golf
//
//  Created by Devil on 14-1-4.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "NSDictionary+Devil.h"

@implementation NSDictionary (Devil)
- (id)valueForKeyWithOutNSNull:(NSString *)key
{
    id value = [self valueForKey:key];
    return [value class] != [NSNull class] ? value :nil;
}

- (NSString *)valueForKeyWithOutUseNull:(NSString *)key
{
	NSString *stringValue = [self valueForKeyWithOutNSNull:key];
	if(stringValue)
	{
		return stringValue;
	}
	return @"";
}

- (int)intValueWithDefaultVaule:(NSString*)key
{
	NSString *stringValue = [self valueForKeyWithOutNSNull:key];
	if(stringValue)
	{
		return [stringValue intValue];
	}
	return -1;
}
@end
