//
//  NSDictionary+Devil.h
//  13Golf
//
//  Created by Devil on 14-1-4.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Devil)
- (id)valueForKeyWithOutNSNull:(NSString *)key;

// return the key int value in json string,default value is -1;
- (int)intValueWithDefaultVaule:(NSString*)key;

- (NSString *)valueForKeyWithOutUseNull:(NSString *)key;

@end
