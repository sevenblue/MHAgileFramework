//
//  MHBaseModel.m
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "MHBaseModel.h"
#import "NSDictionary+Devil.h"
#import "NSStringAdditions.h"
#import "NSData+IJson.h"

@implementation MHBaseModel

@end

@implementation UserModel

+ (UserModel *)paserDataWithDic:(NSDictionary *)data
{
    UserModel * model = [UserModel new];
    model.userID = [[data valueForKeyWithOutNSNull:@"id"] intValue];
    model.userName = [data valueForKeyWithOutNSNull:@"userName"];
    model.pwd = [data valueForKeyWithOutNSNull:@"passWord"];
    model.email = [data valueForKeyWithOutNSNull:@"email"];
    model.phone = [data valueForKeyWithOutNSNull:@"phone"];
    
    model.headUrl = [data valueForKeyWithOutNSNull:@"headUrl"];
    model.playAge = [[data valueForKeyWithOutNSNull:@"playAge"] intValue];
    model.description = [data valueForKeyWithOutNSNull:@"description"];
    model.handicap = [NSString stringWithFormat:@"差点:%.2f",[[data valueForKeyWithOutNSNull:@"handicap"]intValue]?[[data valueForKeyWithOutNSNull:@"handicap"]intValue ]:0.00];
    model.createdTime = [data valueForKeyWithOutNSNull:@"createdTime"];
    model.token = [data valueForKeyWithOutNSNull:@"token"];
    model.city = [data valueForKeyWithOutNSNull:@"city"];
    model.status = [[data valueForKeyWithOutNSNull:@"status"] intValue];
    model.friendCount = [[data valueForKeyWithOutNSNull:@"friendCount"] intValue];
    model.followCount = [[data valueForKeyWithOutNSNull:@"followCount"] intValue];
    model.fansCount = [[data valueForKeyWithOutNSNull:@"fansCount"] intValue];
    model.realName = [data valueForKeyWithOutNSNull:@"realName"];
    model.sfzId = [data valueForKeyWithOutNSNull:@"sfzId"];
    
    return model;
}


@end

//--------------------------tableView datasource
@implementation TableDataModel

+ (TableDataModel *)setInfoByDictionary:(NSDictionary *)dic type:(ACTIONTYPE)actionType
{
    switch (actionType) {
        case ACTIONTYPE_MAIN:
        {
            //            return [GolfModel setInfoToPlayerList:dic];
            break;
        }
        default:
            break;
    }
    return nil;
    
}

@end


#pragma mark -
#pragma mark ----------ResponseModel---------


@implementation  ResponseState

+ (ResponseState *)responseStateWithDictionary:(NSDictionary *)dic
{
    ResponseState *state = [[ResponseState alloc] init];
    state.message = [dic valueForKeyWithOutNSNull:@"msg"];
	
    state.code = -1;
	NSString *tmpCode = [NSString nilString:[NSString stringWithFormat:@"%@",[dic valueForKeyWithOutNSNull:@"status"]]];
	if([tmpCode length] > 0)
	{
		state.code = [tmpCode intValue];
	}
    return state;
}

@end

//BaseResponseModel
@implementation BaseResponse
- (id)initWithNetWorkDatas:(id)data
{
	if(self = [super init])
	{
		[self setResponseState:[ResponseState responseStateWithDictionary:data]];
        self.responseData = [data valueForKeyWithOutNSNull:@"data"];
	}
	return self;
}
+ (id)responseWithData:(id)data
{
	return [[BaseResponse alloc] initWithNetWorkDatas:data];
}
@end //UserMode

//=============== Response model Start ===============

@implementation LoginResponse

- (id)initWithNetWorkDatas:(id)data
{
	if(self = [super initWithNetWorkDatas:data])
	{
        NSDictionary * userDic = [data valueForKeyWithOutNSNull:@"data"];
        self.user = [UserModel paserDataWithDic:userDic];
    }
	return self;
}
@end

