//
//  NSObject+MHObjectExtend.m
//  13Golf
//
//  Created by M.H.Yu on 14-1-6.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "NSObject+MHObjectExtend.h"

@implementation NSObject (MHObjectExtend)
+ (id)initializeViewController:(NSString *)className;{
    Class class = NSClassFromString(className);
    id obj = [[class alloc]init];
    
    return obj;
}
@end
