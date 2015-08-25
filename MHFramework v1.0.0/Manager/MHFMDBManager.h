//
//  MHFMDBManager.h
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-8-22.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//
/**
 *  DB
 *  实现批量更新sql
 *  增删改查
 */

#import "MHBaseObject.h"
@interface MHFMDBManager : MHBaseObject

AS_SINGLETON(MHFMDBManager);

@property(retain,nonatomic)id classValues;

//是否存在数据库
-(BOOL)IsDataBase:(NSString *)tableName;
//创建数据库
-(void)CreateDataBase;
//创建表
-(void)CreateTable;

//添加数据
-(void)insertToDBWithModelList:(id)ModelList inDB:(NSString *)tableName modelClass:(Class)modelClass;
-(void)insertToDBWithModel:(id)Model inDB:(NSString *)tableName;
//修改数据
-(void)updateToDB:(id)Model inDB:(NSString *)tableName;
//删除单条数据
-(void)deleteToDB:(id)Model inDB:(NSString *)tableName;
//删除表的数据
-(void)clearAllDataInDB:(NSString *)tableName;
//根据条件删除数据
-(void)deleteWhereData:(NSDictionary *)Model inDB:(NSString *)tableName;
//查找数据
-(void)searchWhere:(NSDictionary *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count inDB:(NSString *)tableName callback:(void(^)(NSArray *))result;

@end
