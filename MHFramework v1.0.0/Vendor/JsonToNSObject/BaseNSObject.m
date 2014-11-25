//
// Created by cai on 13-1-6.
//
//


#import <objc/runtime.h>
#import "BaseNSObject.h"

@interface BaseNSObject ()

@end

@implementation BaseNSObject

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
{
    NSLog(@"key = %@ value = %@",key,value);
}

+ (NSDictionary *)keyDict
{
    id obj = objc_getClass([NSStringFromClass([self class]) cStringUsingEncoding:4]);
    unsigned int outCount,i;
    objc_property_t     *properties = class_copyPropertyList(obj,&outCount);
    NSMutableDictionary *keyDict     = [NSMutableDictionary dictionaryWithCapacity:outCount];
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:4];
        [keyDict setValue:propertyName forKey:propertyName];
    }
    free(properties);
    return keyDict;
}

@end