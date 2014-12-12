//
//  NSArray+MHJson.h
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/12.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MHJson)

- (NSObject *)jsonDataToNSObjectClass:(Class)aClass;

- (id)jsonDataToNSObjectsClass:(Class)aClass;

@end
