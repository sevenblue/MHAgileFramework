//
//  MHBaseViewController.m
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "MHBaseViewController.h"
#import "MHAFNetworkingManager.h"
#import "SVProgressHUD.h"
#import "ParseTool.h"
#import <objc/runtime.h>
#import "NSDictionary+Devil.h"

#define KEY_USERINFO_DICT @"KEY_USERINFO_DICT"

@implementation UIViewController (UserInfo)

- (NSMutableDictionary *)userInfo
{
    NSMutableDictionary *dic = objc_getAssociatedObject(self, KEY_USERINFO_DICT);
    if (!dic) {
        dic = [NSMutableDictionary new];
        objc_setAssociatedObject(self, KEY_USERINFO_DICT, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dic;
}

- (void)releaseUserInfo
{
    NSMutableDictionary *dic = objc_getAssociatedObject(self, KEY_USERINFO_DICT);
    if (dic) {
        objc_removeAssociatedObjects(dic);
    }
}

- (id)objectForKey:(id)key
{
    return [self.userInfo valueForKeyWithOutNSNull:key];
}

- (void)setObject:(id)object forKey:(id)key{
    
    [self.userInfo setObject:object forKey:key];
}

- (void)removeObjectForKey:(id)key
{
    [self.userInfo setObject:[NSNull null] forKey:key];
}

@end

@interface MHBaseViewController ()

@end

@implementation MHBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)loadDataWithURL:(NSString *)url param:(NSDictionary *)parameters response:(responseHandler)handler
{
    Class cls;
    if ([[MHUserInfo sharedInstance]state] == LOADSTATE_UNLOAD) {
        [self showAlertWithTitle:@"提示" andMessage:@"用户未登录!"];
        //TODO
        //push to load interface
        return;
    }
    
    [self loadDataWithURL:url param:parameters response:handler class:cls];
}

- (void)loadDataWithURL:(NSString *)url param:(NSDictionary *)parameters response:(responseHandler)handler class:(Class)cls{
    [[MHAFNetworkingManager sharedInstance] postWithUrl:url param:parameters success:^(id responseObject, NSDictionary *resquestParam) {
            NSLog(@"msg:%@",[responseObject objectForKey:@"msg"]);
            BaseResponse * response  =(BaseResponse *)[ParseTool responseModelClass:cls andResposeObject:responseObject];
            switch (response.responseState.code)
            {
                case kStatusCodeSuccess:
                {
                    [self dismissWithStatus:response.responseState.message];
                    //TODO
                    if (response)
                    {
                        handler(responseObject,resquestParam);
                    }
                }
                    break;
                case kStatusCodeError:
                    [self dismissErrorWithStatus:response.responseState.message];
                case kStatusCodeTokenExpired:
                case kStatusCodeAppKeyError:
                {
                    [self dismissErrorWithStatus:response.responseState.message];
                    break;
                }
                default:
                    break;
            }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - HUD
- (void)showAlertWithTitle:(NSString*) title andMessage:(NSString*) message
{
	if ([message length] <= 0 )
    {
        return;
    }
    NSString* cancelBtnTitle = @"确定";
    UIAlertView* alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:self
                              cancelButtonTitle:cancelBtnTitle
                              otherButtonTitles:nil];
    [alertView show];
}

- (void)showWithStatus:(NSString *)status
{
    if (!status) {
        status = @"加载中...";
    }
	[SVProgressHUD showWithStatus:status];
}

- (void)show
{
	[SVProgressHUD show];
}


- (void)dismiss
{
	[SVProgressHUD dismiss];
}

- (void)dismissWithStatus:(NSString *)status
{
    if (!status) {
        status = @"加载完成";
    }
	[SVProgressHUD showSuccessWithStatus:status];
}

- (void)dismissErrorWithStatus:(NSString *)status
{
    if (!status) {
        status = @"加载失败";
    }
	[SVProgressHUD showErrorWithStatus:status];
}

- (void)showNetError
{
    [SVProgressHUD showErrorWithStatus:@"网络异常请稍后重试"];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"=====currentClass = %@========\n",self.class);
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
    [self initData];
    
    [self addUI];
}

- (void)initData{
    
}

- (void)addUI{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
}

@end
