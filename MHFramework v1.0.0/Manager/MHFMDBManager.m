//
//  MHFMDBManager.m
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-8-22.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//


#import "MHFMDBManager.h"
#import "FMDatabaseQueue.h"
#import "SandboxFile.h"
#import "MHDataBaseDAO.h"

extern NSString * const kSQLHelper_ValueArray;
extern NSString * const kSQLHelper_SqlString;
extern NSString * const kSQLHelper_SqlValue;

@implementation MHFMDBManager

static FMDatabaseQueue* _queue;
@synthesize classValues;

DEF_SINGLETON(MHFMDBManager);

#pragma mark - DB Initilize
-(BOOL)IsDataBase:(NSString *)tableName
{
    BOOL Value=NO;
    if (![SandboxFile IsFileExists:GetDataBasePath(tableName)])
    {
        Value = YES;
    }
    return Value;
}

-(void)CreateDataBase
{
    NSLog(@"DBPath:%@",GetDataBasePath(@"globle_tables"));
    _queue = [[FMDatabaseQueue alloc]initWithPath:GetDataBasePath(@"globle_tables")];
}

-(void)CreateTable
{
    id result = [[MHDataBaseDAO alloc]initWithDBQueue:_queue];
    NSLog(@"result%@",result);
}

#pragma mark - factory
- (id)Factory:(NSString *)tableName modelClass:(Class)modelClass
{
    _queue = nil;
    _queue=[[FMDatabaseQueue alloc]initWithPath:GetDataBasePath(tableName)];
    NSLog(@"DBPath:%@",GetDataBasePath(tableName));
    return [[MHDataBaseDAO alloc]initWithDBQueue:_queue inTable:tableName modelClass:modelClass];
}

-(id)Factory:(NSString *)tableName
{
    return [self Factory:tableName modelClass:nil];
}

#pragma mark - 增
-(void)insertToDBWithModelList:(id)ModelList inDB:(NSString *)tableName modelClass:(Class)modelClass;
{
    self.classValues = [self Factory:tableName modelClass:modelClass];
    [classValues insertModelListToDB:ModelList callback:^(BOOL Values) {
        NSLog(@"批量添加%d",Values);
    }];
}

-(void)insertToDBWithModel:(id)Model inDB:(NSString *)tableName
{
    self.classValues = [self Factory:tableName];
    [classValues insertToDB:Model callback:^(BOOL Values)
     {
         NSLog(@"添加%d",Values);
     }];
}

#pragma mark - 改
-(void)updateToDB:(id)Model inDB:(NSString *)tableName
{
    self.classValues = [self Factory:tableName];
    [classValues updateToDB:Model callback:^(BOOL Values)
     {
         NSLog(@"修改%d",Values);
     }];
}

#pragma mark - 删
-(void)deleteToDB:(id)Model inDB:(NSString *)tableName
{
    self.classValues = [self Factory:tableName];
    [classValues deleteToDB:Model callback:^(BOOL Values)
     {
         NSLog(@"删除%d",Values);
     }];
}

-(void)clearAllDataInDB:(NSString *)tableName
{
    self.classValues = [self Factory:tableName];
    [classValues clearTableData];
    NSLog(@"删除全部数据");
}

-(void)deleteWhereData:(NSDictionary *)Model inDB:(NSString *)tableName
{
    self.classValues = [self Factory:tableName];
    [classValues deleteToDBWithWhereDic:Model callback:^(BOOL Values)
     {
         NSLog(@"删除成功");
     }];
}

#pragma mark - 查
-(void)searchWhere:(NSDictionary *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count inDB:(NSString *)tableName callback:(void(^)(NSArray *))result
{
    self.classValues = [self Factory:tableName];
    [classValues searchWhereDic:where orderBy:columeName offset:offset count:count callback:^(NSArray *array)
     {
         result(array);
     }];
}

#pragma mark -
-(void)dealloc
{
    classValues = nil;
}

@end
