//
//  UIView+NIBView.m
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "UIView+NIBView.h"

@implementation UIView (NIBView)

+ (id)loadXIB:(id)owner option:(NSDictionary*)dic
{
	return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:owner options:dic]lastObject];
}

@end
