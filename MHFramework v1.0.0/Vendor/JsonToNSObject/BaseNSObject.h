//
// Created by cai on 13-1-6.
//
//



#import <Foundation/Foundation.h>
#import "MHBaseModel.h"

@interface BaseNSObject : MHBaseModel<MHDataBaseModelInteface>

@property (nonatomic,copy)   NSString* primaryKey;  //主键名称 如果没有rowid 则跟据此名称update 和delete
@property (nonatomic,assign) int       rowid;       //数据库的 rowid

+ (NSDictionary *)keyDict;

@end