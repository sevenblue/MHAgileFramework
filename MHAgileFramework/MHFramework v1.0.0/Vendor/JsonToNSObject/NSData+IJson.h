//
// Created by cai on 13-1-6.
//
//


#import <Foundation/Foundation.h>

@interface NSData (IJson)

- (NSObject *)jsonDataToNSObjectWithKey:(NSString *)aKey andClass:(Class)aClass;

- (NSArray *)jsonDataToNSObjectsWithKey:(NSString *)aKey andClass:(Class)aClass;

@end