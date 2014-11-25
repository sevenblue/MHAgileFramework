//
//  NSStringAdditions.m
//  BizIQ
//
//  Created by zhoucy on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

  

@implementation NSString(isPureInt)

- (BOOL)isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self]; 
    int val; 
    return[scan scanInt:&val] && [scan isAtEnd];
}

+ (NSString*)nilString:(NSString*)srcString
{
	if(nil == srcString)
		return @"";
	return [NSString stringWithString:srcString];
}

+ (NSString*)decorateStringWithDotsByLength:(uint)limitLength string:(NSString*)srcString
{
	if([srcString length] > limitLength)
	{
		return [NSString stringWithFormat:@"%@...",[srcString substringWithRange:NSMakeRange(0, limitLength)]];
	}
	
	return [NSString stringWithString:[srcString length] > 0 ? srcString : @""];
}

+ (NSString*)stringToZeroValueString:(NSString*)srcString
{
	if([srcString length] <= 0)
	{
		return @"0";
	}
	
	return [NSString stringWithString:srcString];
}

+ (NSString*)stringFromDouble:(double)value
{
	return [NSString stringWithFormat:@"%f",value];
}


+ (NSString*)stringWithIntValue:(int)value
{
	return [NSString stringWithFormat:@"%d",value];
}
+ (NSString *)lastString:(NSString *)_str
{
    NSArray * arr = [_str componentsSeparatedByString:@"="];
    return [arr lastObject];
}

+ (NSString *)headString:(NSString *)_str
{
    NSArray * arr = [_str componentsSeparatedByString:@"="];
    return [arr objectAtIndex:0];
}

+ (NSString *)stringWithMaxLength:(int)length string:(NSString*)srcString
{
	NSString *result = [NSString stringWithString:srcString];
	if([srcString length] > length)
	{
		result = [NSString stringWithFormat:@"%@...",[srcString substringWithRange:NSMakeRange(0, length)]];
	}
	return  result;
}



+ (id)newContentByOld:(NSString*)oldString newString:(NSString*)string
{
	id result = [NSNull null];
	if(nil == oldString)
	{
		result = (nil == string ? [NSNull null] : string);
	}else
	{
		result = [oldString isEqualToString:string] ? [NSNull null] : string;
	}
	return result;
}

+ (NSString *)removeSpace:(NSString*)text
{
    return  [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+ (NSString *)createID
{
    return [NSString stringWithFormat:@"%f",[[NSDate date]timeIntervalSince1970]];
}

+ (int)fromUID:(NSString *)bareStr
{
    NSArray * separatedArr = [bareStr componentsSeparatedByString:@"@"];
    return [[separatedArr firstObject] intValue];
}


- (id)JSONValue
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
   
    if (data)
        return json;
    return nil;
}
@end