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

//--------------------------tableView datasource
@implementation TableDataModel

+ (TableDataModel *)setInfoByDictionary:(NSDictionary *)dic type:(ACTIONTYPE)actionType
{
    switch (actionType) {
        case ACTIONTYPE_MAIN:
        {
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
@end


