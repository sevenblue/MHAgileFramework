//
//  NSDictionary+MHJson.h
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/12.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MHJson)

- (NSObject *)jsonDataToNSObjectClass:(Class)aClass;

- (id)jsonDataToNSObjectsClass:(Class)aClass;

@end
