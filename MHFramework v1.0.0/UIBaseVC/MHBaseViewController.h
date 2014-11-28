//
//  MHBaseViewController.h
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHBaseModel.h"
/**
 *  Extension: 为每个VC挂上一个userInfo，
 */
@interface UIViewController (UserInfo)
- (id)objectForKey:(id)key;
- (void)setObject:(id)object forKey:(id)key;
- (void)removeObjectForKey:(id)key;
@end

typedef void (^responseHandler)(id result);

@interface MHBaseViewController : UIViewController

#pragma mark - NETWORK
- (void)loadDataWithURL:(NSString *)url param:(NSDictionary *)parameters response:(responseHandler)handler;

#pragma mark - FUN
- (void)initData;
- (void)addUI;

#pragma mark - HUD
//shouw alert & HUD if need
- (void)showAlertWithTitle:(NSString*) title andMessage:(NSString*) message;
- (void)show;
- (void)showWithStatus:(NSString *)status;
- (void)showNetError;

- (void)dismiss;
- (void)dismissErrorWithStatus:(NSString *)status;
- (void)dismissWithStatus:(NSString *)status;

@end

