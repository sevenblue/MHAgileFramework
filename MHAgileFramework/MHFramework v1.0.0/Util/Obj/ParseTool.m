//
//  ParseTool.m
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "ParseTool.h"
#import "MHBaseModel.h"
@implementation ParseTool
+(id)responseModelClass:(Class)cls andResposeObject:(id)obj
{
	BaseResponse *dataModle = [[cls alloc] initWithNetWorkDatas:obj];
    return dataModle;
}
@end
