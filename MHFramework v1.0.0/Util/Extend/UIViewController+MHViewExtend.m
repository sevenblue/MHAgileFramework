//
//  UIViewController+MHViewExtend.m
//  13Golf
//
//  Created by M.H.Yu on 14-1-6.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "UIViewController+MHViewExtend.h"

@implementation UIViewController (MHViewExtend)

+ (id)initializeViewController:(NSString *)className hasNib:(BOOL )bool_;{
    id vc;
    Class class = NSClassFromString(className);
    if (bool_) {
        vc = [[class alloc]initWithNibName:className bundle:nil];
    }else{
        vc = [[class alloc]init];
    }
    return vc;
}

@end
