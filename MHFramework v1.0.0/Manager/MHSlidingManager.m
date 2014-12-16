//
//  MHECSlidingManager.m
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "MHSlidingManager.h"
//#import "MHMainInterfaceViewController.h"
//#import "MHLeftSliderViewController.h"
//#import "MHRightSliderViewController.h"

@implementation MHSlidingManager

static YRSideViewController *_sideViewController = nil;

DEF_SINGLETON(MHSlidingManager)

#pragma mark - setup sliderController
- (void )setupSliderController{
//    MHMainInterfaceViewController *mainViewController=[[MHMainInterfaceViewController alloc]initWithNibName:@"MHMainInterfaceViewController" bundle:nil];
//    mainViewController.view.backgroundColor=[UIColor grayColor];
//    
//    MHLeftSliderViewController *leftViewController=[[MHLeftSliderViewController alloc]initWithNibName:@"MHLeftSliderViewController" bundle:nil];
//    leftViewController.view.backgroundColor=[UIColor brownColor];
//    
//    MHRightSliderViewController *rightViewController=[[MHRightSliderViewController alloc]initWithNibName:@"MHRightSliderViewController" bundle:nil];
//    rightViewController.view.backgroundColor=[UIColor purpleColor];
//    
//    _sideViewController=[[YRSideViewController alloc]initWithNibName:nil bundle:nil];
//    _sideViewController.rootViewController=[[UINavigationController  alloc]initWithRootViewController:mainViewController];
//    _sideViewController.leftViewController=leftViewController;
//    _sideViewController.rightViewController=rightViewController;
//    [_sideViewController setRootViewMoveBlock:^(UIView *rootView, CGRect orginFrame, CGFloat xoffset) {
//        //使用简单的平移动画
//        rootView.frame=CGRectMake(xoffset, orginFrame.origin.y, orginFrame.size.width, orginFrame.size.height);
//    }];
//    _sideViewController.leftViewShowWidth=200;
//    _sideViewController.needSwipeShowMenu=true;//默认开启的可滑动展示
//    //动画效果可以被自己自定义，具体请看api
}

#pragma mark - getter SideViewController
- (YRSideViewController *)getSideViewController{
    return _sideViewController;
}

#pragma mark - show left OR right sideView
- (void)showLeftViewController:(BOOL)animated{
    return [_sideViewController showLeftViewController:animated];
}

- (void)showRightViewController:(BOOL)animated{
    return [_sideViewController showRightViewController:animated];
}

#pragma mark - hide
- (void)hideSideViewController:(BOOL)animated{
    return [_sideViewController hideSideViewController:animated];
}

@end
