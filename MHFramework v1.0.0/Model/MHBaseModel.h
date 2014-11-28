//
//  MHBaseModel.h
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHBaseModel : NSObject

@end

@interface UserModel : MHBaseModel
@property (nonatomic,assign) int userID;
@property (nonatomic,assign) int status;
@property (nonatomic,assign) int friendCount;
@property (nonatomic,assign) int followCount;
@property (nonatomic,assign) int fansCount;

@property (nonatomic,copy) NSString * userName;
@property (nonatomic,copy) NSString * pwd;
@property (nonatomic,copy) NSString * email;
@property (nonatomic,copy) NSString * phone;

@property (nonatomic,copy) NSString * headUrl;
@property (nonatomic,copy) NSString * description;
@property (nonatomic,assign) int playAge;
@property (nonatomic,copy) NSString * handicap;
@property (nonatomic,copy) NSString * createdTime;
@property (nonatomic,copy) NSString * token;
@property (nonatomic,copy) NSString * city;
@property (nonatomic,copy) NSString * realName;
@property (nonatomic,copy) NSString * sfzId;

+ (UserModel *)paserDataWithDic:(NSDictionary *)data;
@end


//================= tableView model==================
//tableView dataSource
@interface TableDataModel  : MHBaseModel

+ (TableDataModel *)setInfoByDictionary:(NSDictionary *)dic type:(ACTIONTYPE)actionType;

@end


//================= BaseResponse==================
@interface ResponseState : MHBaseModel

@property (assign, nonatomic) int code;
@property (copy, nonatomic) NSString *message;
+ (ResponseState *)responseStateWithDictionary:(NSDictionary *)dic;

@end


@interface BaseResponse : MHBaseModel

@property(nonatomic, retain) ResponseState	*responseState;
@property(nonatomic,strong) NSDictionary *responseData;
- (id)initWithNetWorkDatas:(id)data;
+ (id)responseWithData:(id)data;

@end


@interface LoginResponse : BaseResponse
@property (nonatomic,strong) UserModel * user;
@end