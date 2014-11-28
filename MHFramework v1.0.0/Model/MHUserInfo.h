//
//  MHUserInfo.h
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHBaseModel.h"

typedef enum {
    LOADSTATE_UNLOAD = 0,
    LOADSTATE_LOAD
}LOADSTATE;

@interface MHUserInfo : NSObject

@property (nonatomic, assign)LOADSTATE state;

AS_SINGLETON(MHUserInfo);

- (void)setFullUser:(UserModel*)user;

- (UserModel*)fullUser;

- (BOOL)isUserExist;

- (int)userID;

-(NSString *)userName;

- (void)loadOut;

@end
