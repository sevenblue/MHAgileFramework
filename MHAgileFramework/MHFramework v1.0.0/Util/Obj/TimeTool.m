//
//  TimeTool.m
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool
//为了与服务器统一 这里的时间戳要*1000
+ (double)currentTimeStamp
{
    return [[NSDate date]timeIntervalSince1970] *1000;
}

+ (NSString *)transformCurrentDate:(NSString*)currentStr
{
    //formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //date
    NSDate * d = [dateFormatter dateFromString:currentStr];
    NSTimeInterval late = [d timeIntervalSince1970]*1;
    
    NSString * timeString = nil;
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    NSTimeInterval cha = now - late;
    if (cha/3600 < 1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        int num= [timeString intValue];
        
        if (num <= 1) {
            
            timeString = [NSString stringWithFormat:@"刚刚"];
            
        }else{
            
            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
        }
    }
    
    if (cha/3600 > 1 && cha/86400 < 1) {
        
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
        
    }
    
    if (cha/86400 > 1)
        
    {
        
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        int num = [timeString intValue];
        
        if (num < 2) {
            
            timeString = [NSString stringWithFormat:@"昨天"];
            
        }else if(num == 2){
            
            timeString = [NSString stringWithFormat:@"前天"];
            
        }else if (num > 2 && num <7){
            
            timeString = [NSString stringWithFormat:@"%@天前", timeString];
            
        }else if (num >= 7 && num <= 10) {
            
            timeString = [NSString stringWithFormat:@"1周前"];
            
        }else if(num > 10){
            
            timeString = [NSString stringWithFormat:@"n天前"];
            
        }
        
    }
//    上述好像有个弊端，忘记了，对于最近的时间，可以用下面的判断
//    
//    NSTimeInterval secondPerDay = 24*60*60;
//    
//    NSDate * yesterDay = [NSDate dateWithTimeIntervalSinceNow:-secondPerDay];
//    
//    NSCalendar * calendar = [NSCalendar currentCalendar];
//    
//    unsigned uintFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
//    
//    NSDateComponents * souretime = [calendar components:uintFlags fromDate:d];
//    
//    NSDateComponents * yesterday = [calendar components:uintFlags fromDate:yesterDay];
//    
//    if (souretime.year == yesterday.year && souretime.month == yesterday.month && souretime.day == yesterday.day){
//        
//        [yourformatter setDateFormat:@"HH:mm"];
//        
//        timeString = [NSString stringWithFormat:@"  昨天 %@  ",[self.hourformatter stringFromDate:d]];
//    }
    return timeString;
}
@end
