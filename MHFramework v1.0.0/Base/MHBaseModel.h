//
//  MHBaseModel.h
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  接口继承，要存入sqlite的model必须实现此protocol
 */
@protocol MHDataBaseModelInteface <NSObject>
@property (nonatomic,copy)   NSString* primaryKey;  //主键名称 如果没有rowid 则跟据此名称update 和delete
@property (nonatomic,assign) int       rowid;       //数据库的 rowid
@end

@interface MHBaseModel : NSObject

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