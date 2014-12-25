//
//  MHBaseViewController+NavigationBar.m
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/11/21.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "MHBaseViewController+NavigationBar.h"
#import <objc/runtime.h>

static const NSString *LeftBtnClickedHandlerKey = @"LeftBtnClickedHandlerKey";
static const NSString *RightBtnClickedHandlerKey = @"RightBtnClickedHandlerKey";

@implementation MHBaseViewController (NavigationBar)

#pragma mark - setter navigationBarButton style
- (void)setLeftBarButtonWithImage:(UIImage *)image selectHandle:(void(^)())handle{
    if (self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    [self setLeftBtnClickedHandler:handle];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0,StatusBarHeight+22,44,44);
    [leftBtn setImage:image forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarButtonClict:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = btnItem;
}

- (void)setRightBarButtonWithImage:(UIImage *)image selectHandle:(void(^)())handle{
    if (self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    [self setLeftBtnClickedHandler:handle];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(320-44,StatusBarHeight+22,44,44);
    [rightBtn setImage:image forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBarButtonClict:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = btnItem;
}

- (void)leftBarButtonClict:(id)sender
{
    
    if ([self.navigationController.viewControllers count]>0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    if ([self leftBtnClickedHandler]) {
        ((void(^)())[self leftBtnClickedHandler])();
    }
}

- (void)rightBarButtonClict:(id)sender{
    if ([self rightBtnClickedHandler]) {
        ((void(^)())[self rightBtnClickedHandler])();
    }
}
#pragma mark - setter & getter left or right btn click handler
//leftHandler
- (id)leftBtnClickedHandler{
    return [self objectForKey:LeftBtnClickedHandlerKey];
}

- (void)setLeftBtnClickedHandler:(id)handler{
    [self setObject:handler forKey:LeftBtnClickedHandlerKey];
}

//rightHandler
- (id)rightBtnClickedHandler{
    return [self objectForKey:RightBtnClickedHandlerKey];
}

- (void)setRightBtnClickedHandler:(id)handler{
    [self setObject:handler forKey:(RightBtnClickedHandlerKey)];
}

#pragma mark - getter left or right btn
- (UIButton*)leftBarButton
{
    UIView *tmpView = self.navigationItem.leftBarButtonItem.customView;
    return [tmpView isKindOfClass:[UIButton class]] ? (UIButton*)tmpView : nil;
}

- (UIButton*)rightBarButton
{
    UIView *tmpView = self.navigationItem.rightBarButtonItem.customView;
    return [tmpView isKindOfClass:[UIButton class]] ? (UIButton*)tmpView : nil;
}

@end
