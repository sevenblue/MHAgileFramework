//
//  MHBaseViewController+NavigationBar.h
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/11/21.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "MHBaseViewController.h"

@interface MHBaseViewController (NavigationBar)

//reset bar button if need
- (UIButton*)leftBarButton;
- (UIButton*)rightBarButton;

- (void)setLeftBarButtonWithImage:(UIImage *)image selectHandle:(void(^)())handle;
- (void)setRightBarButtonWithImage:(UIImage *)image selectHandle:(void(^)())handle;

@end
