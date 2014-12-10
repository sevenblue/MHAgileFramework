//
//  NSObject+GetPropertys.h
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-8-27.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GetPropertys)

+(NSDictionary*)getPropertys; //返回 该类的所有属性 不上溯到 父类
+(void)getSelfPropertys:(NSMutableArray *)pronames protypes:(NSMutableArray *)protypes isGetSuper:(BOOL)isGetSuper;//获取自身的属性 是否获取父类

@end
