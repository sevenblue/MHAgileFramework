//
//  MHJsonModel.m
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/11.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "MHJsonModel.h"

@implementation MHJsonModel

+ (NSDictionary *)keyDict{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[super keyDict]];
    [dict setValue:@"MHElementModel" forKey:@"children"];
    return dict;
}

@end
