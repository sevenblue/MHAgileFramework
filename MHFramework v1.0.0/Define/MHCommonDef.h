//
//  MHCommonDef.h
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

//--------------------------------------Key Start----------------------------------

//--------------------------------------Key END----------------------------------


//-----------------------------Status Start ----------------------



//-----------------------------Status END ----------------------


//--------------------------------------Func Start----------------------------------
#define SharedAppDelegate ((MHAppDelegate*)[[UIApplication sharedApplication] delegate])

//notification
#define NotiAdd(function,notiName) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(function) name:notiName object:nil]
#define NotiPost(notiName,obj) [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:obj]

//Singletion
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

//version
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define isIOS7AndLater    ([[[UIDevice currentDevice] systemVersion] intValue] >=7)

//Status Bar height
#define StatusBarHeight isIOS7AndLater?20:0

//颜色定义
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//--------------------------------------Func END----------------------------------


//--------------------------------------Notification Start----------------------------------
//Noti格式规则 添加Noti前缀

//--------------------------------------Notification END----------------------------------


//--------------------------------------Url Start----------------------------------
#import "MHCommonURL.h"
//--------------------------------------Url END----------------------------------


//--------------------------------------WORD START----------------------------------


//--------------------------------------WORD END----------------------------------


//--------------------------------------USERDEFAULT START----------------------------------

//--------------------------------------USERDEFAULT END----------------------------------


//--------------------------------------ENUM START----------------------------------

//枚举规则 以大写T开头 enum内容以小写k开头
typedef enum
{
    kStatusCodeSuccess = 200,//表示正常
    kStatusCodeError = 500,//表示异常
    kStatusCodeTokenExpired= 202,//token过期或失效
    kStatusCodeAppKeyError = 501//appKey不正确
}TStatusCode;

typedef enum
{
    kTableViewStyleNone,
    KTableViewStyleWithSegement,
    KTableViewStyleWithCreateGroup
}TTableViewStyle;

typedef enum {
    SIZETYPE_X,
    SIZETYPE_Y,
    SIZETYPE_Heith,
    SIZETYPE_Width
}SIZETYPE;

typedef enum {
    ACTIONTYPE_MAIN
}ACTIONTYPE;
//--------------------------------------ENUM END----------------------------------

//--------------------------------------DEBUG Start----------------------------------
#ifdef DEBUG
#define NSLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define NSLog(format, ...)
#endif

//--------------------------------------DEBUG END----------------------------------

//--------------------------------------Others Start----------------------------------
#define SIZE_NAVIGATIONBAR 44.0f

//--------------------------------------Others END----------------------------------

