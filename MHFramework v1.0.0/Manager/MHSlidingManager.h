//
//  MHECSlidingManager.h
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YRSideViewController.h"

@interface MHSlidingManager : NSObject

AS_SINGLETON(MHSlidingManager)

- (void )setupSliderController;

- (YRSideViewController *)getSideViewController;

- (void)showLeftViewController:(BOOL)animated;//展示左边栏
- (void)showRightViewController:(BOOL)animated;//展示右边栏
- (void)hideSideViewController:(BOOL)animated;//恢复正常位置

@end

