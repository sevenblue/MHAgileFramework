//
//  NSMutableArray+AddObject.h
//  13Golf
//
//  Created by M.H.Yu on 14-1-22.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (AddObject)

+ (void )insertObject:(id)obj atIndex:(NSInteger)index intoArray:(NSMutableArray *)array;

+ (BOOL )addObjectWithOutCommon:(id)obj intoArray:(NSMutableArray *)array;

+ (NSMutableString *)appendObjectFromArray:(NSArray *)array;

+ (NSMutableString *)appendObjectWithUnderlineFromArray:(NSArray *)array;

- (void)addObjectsFromObject:(id)otherArray;

@end
