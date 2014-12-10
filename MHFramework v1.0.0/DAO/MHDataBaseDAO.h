//
//  MHDataBaseDAO.h
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-8-27.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "MHBaseDAO.h"
#import "FMDatabaseQueue.h"

@interface MHDataBaseDAO : MHBaseDAO

-(id)initWithDBQueue:(FMDatabaseQueue*)queue;
@property(retain,nonatomic)FMDatabaseQueue* bindingQueue;
@property(retain,nonatomic)NSMutableDictionary* propertys;  //绑定的model属性集合
@property(retain,nonatomic)NSMutableArray* columeNames; //列名
@property(retain,nonatomic)NSMutableArray* columeTypes; //列类型

//清楚创建表的历史记录
+(void)clearCreateHistory;
//返回表名  所有 Dao 都必须重载此方法
+(const NSString*)getTableName;

//返回绑定的Model Class
+(Class)getBindingModelClass;

-(void)addColume:(NSString*)name type:(NSString*)type;
-(void)addColumePrimary:(NSString *)name type:(NSString *)type;

//返回 create table parameter 语句
-(NSString*)getParameterString;

//创建数据库
-(void)createTable;

//默认返回 15条数据
-(void)searchAll:(void(^)(NSArray*))callback;

//默认返回 15条数据   where 条件 要自己写  比如 where =  @"rowid = 2"
-(void)searchWhere:(NSString*)where callback:(void(^)(NSArray*))block;

//基本sql语句
-(void)searchWhere:(NSString*)where orderBy:(NSString*)columeName offset:(int)offset count:(int)count callback:(void(^)(NSArray*))block;

//查询的条件以 key-value 模式传入
-(void)searchWhereDic:(NSDictionary*)where orderBy:(NSString *)orderby offset:(int)offset count:(int)count callback:(void (^)(NSArray *))block;
-(void)searchWhereDic:(NSDictionary*)where callback:(void(^)(NSArray*))block;

//把 model 插入到 数据库
-(void)insertToDB:(NSObject<MHDataBaseModelInteface>*)model callback:(void(^)(BOOL))block;
-(void)insertModelListToDB:(NSArray *)modelList callback:(void (^)(BOOL))block;
-(void)updateToDB:(NSObject<MHDataBaseModelInteface>*)model callback:(void(^)(BOOL))block;
-(void)deleteToDB:(NSObject<MHDataBaseModelInteface>*)model callback:(void(^)(BOOL))block;
//根据where 条件删除数据
-(void)deleteToDBWithWhere:(NSString*)where callback:(void (^)(BOOL))block;
-(void)deleteToDBWithWhereDic:(NSDictionary*)where callback:(void (^)(BOOL))block;
//当 NSDictionary 的value 是NSArray 类型时  使用 or 当中间值

//清空表数据
-(void)clearTableData;

-(void)isExistsModel:(NSObject<MHDataBaseModelInteface>*)model callback:(void(^)(BOOL))block;
-(void)isExistsWithWhere:(NSString*)where callback:(void (^)(BOOL))block;
+(NSString*)toDBType:(NSString*)type; //把Object-c 类型 转换为sqlite 类型

@end
