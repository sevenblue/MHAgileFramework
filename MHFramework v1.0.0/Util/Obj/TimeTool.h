//
//  TimeTool.h
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//
/*用于计算时间戳 */
#import <Foundation/Foundation.h>

@interface TimeTool : NSObject
+ (double)currentTimeStamp;
+ (NSString *)transformCurrentDate:(NSString*)currentStr;
@end
