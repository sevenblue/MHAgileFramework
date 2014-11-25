//
//  UIView+DevilUIView.m
//  DevilXunna
//
//  Created by Devil on 13-11-13.
//  Copyright (c) 2013年 Devil. All rights reserved.
//

#import "UIView+DevilUIView.h"

@implementation UIView (DevilUIView)
+ (id)viewFromNibByDefaultClassName:(id)owner option:(NSDictionary*)dic
{
    
	return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:owner options:dic]lastObject];
}
@end
