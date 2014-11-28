//
//  UIView+FindFirstResponder.m
//  13Golf
//
//  Created by M.H.Yu on 14-2-22.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "UIView+FindFirstResponder.h"

@implementation UIView (FindFirstResponder)

- (id)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        id responder = [subView findFirstResponder];
        if (responder) return responder;
    }
    return nil;
}

@end
