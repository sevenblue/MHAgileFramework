//
//  NSString+JudgeIfEmpty.m
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-8-27.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "NSString+JudgeIfEmpty.h"

@implementation NSString (JudgeIfEmpty)

-(BOOL)isEmptyWithTrim
{
    return [[self stringWithTrim] isEqualToString:@""];
}
-(NSString *)stringWithTrim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
