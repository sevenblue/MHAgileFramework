//
//  UIImage+bundleImage.m
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/23.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "UIImage+bundleImage.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UIImage (bundleImage)

+ (UIImage *)imagesNamedFromCustomBundle:(NSString *)name
{
    NSString *fullpath = [NSString stringWithFormat:@"MHAgile.bundle/images/%@", name];
    return [self imageNamed:fullpath];
}

@end
