//
//  NSMutableArray+AddObject.m
//  13Golf
//
//  Created by M.H.Yu on 14-1-22.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "NSMutableArray+AddObject.h"

@implementation NSMutableArray (AddObject)

/**
 *  Method for add a obj to array with out commoned obj
 *  @return YES:array中没有与传入obj相同的元素；No:有相同元素
 **/
+ (BOOL )addObjectWithOutCommon:(id)obj intoArray:(NSMutableArray *)array{
    for (id object in array) {
        if ([object isEqual:obj]) {
            return NO;
        }
    }
    [array addObject:obj];
    return YES;
}

+ (void )insertObject:(id)obj atIndex:(NSInteger)index intoArray:(NSMutableArray *)array{
    if ([array count] >= index && obj && index >= 0) {
        [array replaceObjectAtIndex:index withObject:obj];
    }
}

/**
 *  将array中数组提取出来，用“,”隔开，整合到一个string中
 *
 *  @param array 数据源array
 *
 *  @return 整合后的string
 */
+ (NSMutableString *)appendObjectFromArray:(NSArray *)array{
    NSMutableString *str = [NSMutableString new];
    for (id obj in array) {
        [str appendFormat:@"%@",obj];
        if(![obj isEqual:[array lastObject]])[str appendString:@","];
    }
    return str;
}

/**
 *  将array中数组提取出来，用“_”隔开，整合到一个string中
 *
 *  @param array 数据源array
 *
 *  @return 整合后的string
 */
+ (NSMutableString *)appendObjectWithUnderlineFromArray:(NSArray *)array{
    
    //将数组中@""的去除掉
    NSMutableArray *arrWithOutNil = [NSMutableArray new];
    for (id obj in array) {
        if (![obj isEqualToString:@""]) {
            [arrWithOutNil addObject:obj];
        }
    }
    
    //元素中间加"_"
    NSMutableString *str = [NSMutableString new];
    for (int i=0;i<[arrWithOutNil count];i++) {
        id obj = [arrWithOutNil objectAtIndex:i];
        if ([[obj class] isSubclassOfClass:NSClassFromString(@"NSString")]&&[obj length]) {
            [str appendFormat:@"%@",obj];
            if(i!=[arrWithOutNil count]-1)[str appendString:@"_"];
        }
    }
    
    return str;
}

- (void)addObjectsFromObject:(id)otherArray{
    if ([otherArray isKindOfClass:NSClassFromString(@"NSArray")]) {
        [self addObjectsFromArray:otherArray];
    }else{
        [self addObjectsFromArray:@[]];
    }
}

@end
