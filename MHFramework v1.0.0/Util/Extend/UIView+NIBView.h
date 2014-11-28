//
//  UIView+NIBView.h
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NIBView)

+ (id)loadXIB:(id)owner option:(NSDictionary*)dic;

@end
