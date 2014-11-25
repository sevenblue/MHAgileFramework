//
// Created by cai on 13-1-6.
//
//


#import <Foundation/Foundation.h>

@interface NSString (IJson)

- (NSObject *)jsonStringToNSObjectWithKey:(NSString *)aKey andClass:(Class)aClass;

- (NSArray *)jsonStringToNSObjectsWithKey:(NSString *)aKey andClass:(Class)aClass;

@end