//
//  MHDataBaseDAO.m
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-8-27.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "MHDataBaseDAO.h"
#import "FMResultSet.h"
#import "FMDatabase.h"
#import "SandboxFile.h"
#import "NSObject+GetPropertys.h"
#import "NSString+JudgeIfEmpty.h"
#import <objc/runtime.h>

#define MHSQLText   @"test"
#define MHSQLInt    @"integer"
#define MHSQLDouble @"float"
#define MHSQLBlob   @"blob"
#define MHSQLNull   @"null"
#define MHSQLIntPrimaryKey   @"integer primary key"

@implementation MHDataBaseDAO
@synthesize columeNames;
@synthesize columeTypes;
@synthesize bindingQueue;

-(id)initWithDBQueue:(FMDatabaseQueue *)queue
{
    return [self initWithDBQueue:queue inTable:nil modelClass:nil];
}

-(id)initWithDBQueue:(FMDatabaseQueue *)queue inTable:(NSString *)tableName modelClass:(Class)modelClass
{
    self = [super init];
    if (self)
    {
        self.bindingQueue = queue;
        self.modelClass = modelClass;
        self.tableName = tableName;
        self.columeNames = [NSMutableArray arrayWithCapacity:16];
        self.columeTypes = [NSMutableArray arrayWithCapacity:16];
        
        //获取绑定的 Model 并 保存 Model 的属性信息
        NSDictionary* dic  = [self.modelClass getPropertys];
        NSArray* pronames = [dic objectForKey:@"name"];
        NSArray* protypes = [dic objectForKey:@"type"];
        self.propertys = [NSMutableDictionary dictionaryWithObjects:protypes forKeys:pronames];
        for (int i =0; i<pronames.count; i++) {
            [self addColume:[pronames objectAtIndex:i] type:[protypes objectAtIndex:i]];
        }
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            onceCreateTable = [[NSMutableDictionary alloc]initWithCapacity:8];
        });
        NSString* className = NSStringFromClass(self.class);
        NSNumber* onceToCreate = [onceCreateTable objectForKey:className];
        if(onceToCreate.boolValue == NO)
        {
            [self createTable];
            onceToCreate = [NSNumber numberWithBool:YES];
            [onceCreateTable setObject:onceToCreate forKey:className];
        }
    }
    return self;
    
}

-(void)dealloc
{
    self.bindingQueue = nil;
    self.propertys = nil;
    self.columeNames = nil;
    self.columeTypes = nil;
}

static NSMutableDictionary* onceCreateTable;
+(void)clearCreateHistory
{
    [onceCreateTable removeAllObjects];
}

-(void)createTable
{
    if([self.tableName isEmptyWithTrim])
    {
        NSLog(@"LKTableName is None!");
        return;
    }
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         NSString* createTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@)",self.tableName,[self getParameterString]];
         [db executeUpdate:createTable];
         
     }];
}

-(void)addColume:(NSString *)name type:(NSString *)type
{
    [columeNames addObject:name];
    [columeTypes addObject:[MHDataBaseDAO toDBType:type]];
}

-(void)addColumePrimary:(NSString *)name type:(NSString *)type
{
    [columeNames addObject:name];
    [columeTypes addObject:[NSString stringWithFormat:@"%@ primary key",[MHDataBaseDAO toDBType:type]]];
}

-(NSString *)getParameterString
{
    NSMutableString* pars = [NSMutableString string];
    for (int i=0; i<columeNames.count; i++) {
        [pars appendFormat:@"%@ %@",[columeNames objectAtIndex:i],[columeTypes objectAtIndex:i]];
        if(i+1 !=columeNames.count)
        {
            [pars appendString:@","];
        }
    }
    return pars;
}

-(void)searchAll:(void(^)(NSArray*))callback{
    [self searchWhere:nil orderBy:nil offset:0 count:15 callback:callback];
}

-(void)searchWhere:(NSString*)where callback:(void(^)(NSArray*))block{
    [self searchWhere:where orderBy:nil offset:0 count:15 callback:block];
}

-(void)searchWhereDic:(NSDictionary*)where callback:(void(^)(NSArray*))block{
    [self searchWhereDic:where orderBy:nil offset:0 count:15 callback:block];
}

-(void)searchWhere:(NSString *)where orderBy:(NSString *)orderBy offset:(int)offset count:(int)count callback:(void (^)(NSArray *))block
{
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         NSMutableString* query = [NSMutableString stringWithFormat:@"select rowid,* from %@ ",self.tableName];
         if(where != nil && ![where isEmptyWithTrim])
         {
             [query appendFormat:@" where %@",where];
         }
         [self sqlString:query AddOder:orderBy offset:offset count:count];
         FMResultSet* set =[db executeQuery:query];
         [self executeResult:set block:block];
     }];
}

-(void)searchWhereDic:(NSDictionary*)where orderBy:(NSString *)orderby offset:(int)offset count:(int)count callback:(void (^)(NSArray *))block
{
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         NSMutableString* query = [NSMutableString stringWithFormat:@"select rowid,* from %@ ",self.tableName];
         
         NSMutableArray* values = [NSMutableArray arrayWithCapacity:0];
         if(where !=nil&& where.count>0)
         {
             NSString* wherekey = [self dictionaryToSqlWhere:where andValues:values];
             [query appendFormat:@" where %@",wherekey];
         }
         [self sqlString:query AddOder:orderby offset:offset count:count];
         FMResultSet* set =[db executeQuery:query withArgumentsInArray:values];
         [self executeResult:set block:block];
     }];
}

-(void)sqlString:(NSMutableString*)sql AddOder:(NSString*)orderby offset:(int)offset count:(int)count
{
    if(orderby != nil && ![orderby isEmptyWithTrim])
    {
        [sql appendFormat:@" order by %@ ",orderby];
    }
    [sql appendFormat:@" limit %d offset %d ",count,offset];
}

- (void)executeResult:(FMResultSet *)set block:(void (^)(NSArray *))block
{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        NSObject<MHDataBaseModelInteface>* bindingModel = [[self.modelClass alloc]init];
        bindingModel.rowid = [set intForColumnIndex:0];
        for (int i=0; i<self.columeNames.count; i++) {
            NSString* columeName = [self.columeNames objectAtIndex:i];
            NSString* columeType = [self.propertys objectForKey:columeName];
            if([@"intfloatdoublelongcharshort" rangeOfString:columeType].location != NSNotFound)
            {
                [bindingModel setValue:[NSNumber numberWithDouble:[set doubleForColumn:columeName]] forKey:columeName];
            }
            else if([columeType isEqualToString:@"NSString"])
            {
                [bindingModel setValue:[set stringForColumn:columeName] forKey:columeName];
            }
            else if([columeType isEqualToString:@"UIImage"])
            {
                NSString* filename = [set stringForColumn:columeName];
                if([SandboxFile IsFileExists:[SandboxFile GetPathForDocuments:filename inDir:@"dbImages"]])
                {
                    UIImage* img = [UIImage imageWithContentsOfFile:[SandboxFile GetPathForDocuments:filename inDir:@"dbImages"]];
                    [bindingModel setValue:img forKey:columeName];
                }
            }
            else if([columeType isEqualToString:@"NSDate"])
            {
                NSString* datestr = [set stringForColumn:columeName];
                [bindingModel setValue:[self dateWithString:datestr] forKey:columeName];
            }
            else if([columeType isEqualToString:@"NSData"])
            {
                NSString* filename = [set stringForColumn:columeName];
                if([SandboxFile IsFileExists:[SandboxFile GetPathForDocuments:filename inDir:@"dbData"]])
                {
                    NSData* data = [NSData dataWithContentsOfFile:[SandboxFile GetPathForDocuments:filename inDir:@"dbData"]];
                    [bindingModel setValue:data forKey:columeName];
                }
            }
            else if([columeType isEqualToString:@"NSDictionary"]||[columeType isEqualToString:@"NSArray"]){
                [bindingModel setValue:[NSKeyedUnarchiver unarchiveObjectWithData:[set dataForColumn:columeName]] forKeyPath:columeName];
            }
            
        }
        [array addObject:bindingModel];
    }
    [set close];
    block(array);
}

- (void)insertModelListToDB:(NSArray *)modelList callback:(void (^)(BOOL))block{
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         for (MHBaseModel <MHDataBaseModelInteface> *model in modelList) {
             if (!model)return;
             NSDate* date = [NSDate date];
             NSMutableString* insertKey = [NSMutableString stringWithCapacity:0];
             NSMutableString* insertValuesString = [NSMutableString stringWithCapacity:0];
             NSMutableArray* insertValues = [NSMutableArray arrayWithCapacity:self.columeNames.count];
             if (self.columeNames.count > 0) {
                 for (int i=0; i<self.columeNames.count; i++) {
                     
                     NSString* proname = [self.columeNames objectAtIndex:i];
                     [insertKey appendFormat:@"%@,", proname];
                     [insertValuesString appendString:@"?,"];
                     id value =[self safetyGetModel:model valueKey:proname];
                     if([value isKindOfClass:[UIImage class]])
                     {
                         NSString* filename = [NSString stringWithFormat:@"img%f",[date timeIntervalSince1970]];
                         [UIImageJPEGRepresentation(value, 1) writeToFile:[SandboxFile GetPathForDocuments:filename inDir:@"dbImages"] atomically:YES];
                         value = filename;
                     }
                     else if([value isKindOfClass:[NSData class]])
                     {
                         NSString* filename = [NSString stringWithFormat:@"data%f",[date timeIntervalSince1970]];
                         [value writeToFile:[SandboxFile GetPathForDocuments:filename inDir:@"dbdata"] atomically:YES];
                         value = filename;
                     }
                     else if([value isKindOfClass:[NSDate class]])
                     {
                         value = [self stringWithDate:value];
                     }
                     else if([value isKindOfClass:[NSDictionary class]]||[value isKindOfClass:[NSArray class]]){
                         value = [NSKeyedArchiver archivedDataWithRootObject:value];
                     }
                     [insertValues addObject:value];
                 }
                 [insertKey deleteCharactersInRange:NSMakeRange(insertKey.length - 1, 1)];
                 [insertValuesString deleteCharactersInRange:NSMakeRange(insertValuesString.length - 1, 1)];
                 NSString* insertSQL = [NSString stringWithFormat:@"insert into %@(%@) values(%@)",self.tableName,insertKey,insertValuesString];
                 BOOL execute = [db executeUpdate:insertSQL withArgumentsInArray:insertValues];
                 model.rowid = (int )db.lastInsertRowId;
                 if(block != nil)
                 {
                     block(execute);
                 }
                 if(execute == NO)
                 {
                     NSLog(@"database insert fail %@",NSStringFromClass(model.class));
                 }
             }else//error
             {
                 if(block != nil)
                 {
                     block(NO);
                 }
             }
         }
         
     }];
}

- (void)insertToDB:(NSObject<MHDataBaseModelInteface> *)model callback:(void (^)(BOOL))block{
    
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         NSDate* date = [NSDate date];
         NSMutableString* insertKey = [NSMutableString stringWithCapacity:0];
         NSMutableString* insertValuesString = [NSMutableString stringWithCapacity:0];
         NSMutableArray* insertValues = [NSMutableArray arrayWithCapacity:self.columeNames.count];
         for (int i=0; i<self.columeNames.count; i++) {
             
             NSString* proname = [self.columeNames objectAtIndex:i];
             [insertKey appendFormat:@"%@,", proname];
             [insertValuesString appendString:@"?,"];
             id value =[self safetyGetModel:model valueKey:proname];
             if([value isKindOfClass:[UIImage class]])          //Image
             {
                 NSString* filename = [NSString stringWithFormat:@"img%f",[date timeIntervalSince1970]];
                 [UIImageJPEGRepresentation(value, 1) writeToFile:[SandboxFile GetPathForDocuments:filename inDir:@"dbImages"] atomically:YES];
                 value = filename;
             }
             else if([value isKindOfClass:[NSData class]])      //Data
             {
                 NSString* filename = [NSString stringWithFormat:@"data%f",[date timeIntervalSince1970]];
                 [value writeToFile:[SandboxFile GetPathForDocuments:filename inDir:@"dbdata"] atomically:YES];
                 value = filename;
             }
             else if([value isKindOfClass:[NSDate class]])      //Date
             {
                 value = [self stringWithDate:value];
             }
             [insertValues addObject:value];
         }
         [insertKey deleteCharactersInRange:NSMakeRange(insertKey.length - 1, 1)];
         [insertValuesString deleteCharactersInRange:NSMakeRange(insertValuesString.length - 1, 1)];
         NSString* insertSQL = [NSString stringWithFormat:@"insert into %@(%@) values(%@)",self.tableName,insertKey,insertValuesString];
         BOOL execute = [db executeUpdate:insertSQL withArgumentsInArray:insertValues];
         model.rowid = (int )db.lastInsertRowId;
         if(block != nil)
         {
             block(execute);
         }
         if(execute == NO)
         {
             NSLog(@"database insert fail %@",NSStringFromClass(model.class));
         }
     }];
}

-(void)updateToDB:(NSObject<MHDataBaseModelInteface> *)model callback:(void (^)(BOOL))block
{
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         NSDate* date = [NSDate date];
         NSMutableString* updateKey = [NSMutableString stringWithCapacity:0];
         NSMutableArray* updateValues = [NSMutableArray arrayWithCapacity:self.columeNames.count];
         for (int i=0; i<self.columeNames.count; i++) {
             
             NSString* proname = [self.columeNames objectAtIndex:i];
             [updateKey appendFormat:@" %@=?,", proname];
             
             id value =[self safetyGetModel:model valueKey:proname];
             if([value isKindOfClass:[UIImage class]])
             {
                 NSString* filename = [NSString stringWithFormat:@"img%f",[date timeIntervalSince1970]];
                 [UIImageJPEGRepresentation(value, 1) writeToFile:[SandboxFile GetPathForDocuments:filename inDir:@"dbImages"] atomically:YES];
                 value = filename;
             }
             else if([value isKindOfClass:[NSData class]])
             {
                 NSString* filename = [NSString stringWithFormat:@"data%f",[date timeIntervalSince1970]];
                 [value writeToFile:[SandboxFile GetPathForDocuments:filename inDir:@"dbdata"] atomically:YES];
                 value = filename;
             }
             else if([value isKindOfClass:[NSDate class]])
             {
                 value = [self stringWithDate:value];
             }
             [updateValues addObject:value];
         }
         [updateKey deleteCharactersInRange:NSMakeRange(updateKey.length - 1, 1)];
         NSString* updateSQL;
         if(model.rowid > 0)
         {
             updateSQL = [NSString stringWithFormat:@"update %@ set %@ where rowid=%d",self.tableName,updateKey,model.rowid];
         }
         else
         {
             //如果不通过 rowid 来 更新数据  那 primarykey 一定要有值
             updateSQL = [NSString stringWithFormat:@"update %@ set %@ where %@=?",self.tableName,updateKey,model.primaryKey];
             [updateValues addObject:[self safetyGetModel:model valueKey:model.primaryKey]];
         }
         BOOL execute = [db executeUpdate:updateSQL withArgumentsInArray:updateValues];
         if(block != nil)
         {
             block(execute);
         }
         if(execute == NO)
         {
             NSLog(@"database update fail %@   ----->rowid: %d",NSStringFromClass(model.class),model.rowid);
         }
     }];
    
    
}

-(void)deleteToDB:(NSObject<MHDataBaseModelInteface> *)model callback:(void (^)(BOOL))block{
    
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         NSString* delete;
         BOOL result;
         if(model.rowid > 0)
         {
             delete = [NSString stringWithFormat:@"DELETE FROM %@ where rowid=%d",self.tableName,model.rowid];
             result = [db executeUpdate:delete];
         }
         else
         {
             delete = [NSString stringWithFormat:@"DELETE FROM %@ where %@=?",self.tableName,model.primaryKey];
             result = [db executeUpdate:delete,[self safetyGetModel:model valueKey:model.primaryKey]];
         }
         if(block != nil)
         {
             block(result);
         }
     }];
}

-(void)deleteToDBWithWhere:(NSString *)where callback:(void (^)(BOOL))block
{
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         NSString* delete = [NSString stringWithFormat:@"DELETE FROM %@ where %@",self.tableName,where];
         BOOL result = [db executeUpdate:delete];
         if(block != nil)
         {
             block(result);
         }
     }];
}
-(NSString*)dictionaryToSqlWhere:(NSDictionary*)dic andValues:(NSMutableArray*)values
{
    NSMutableString* wherekey = [NSMutableString stringWithCapacity:0];
    if(dic != nil && dic.count >0 )
    {
        NSArray* keys = dic.allKeys;
        for (int i=0; i< keys.count;i++) {
            
            NSString* key = [keys objectAtIndex:i];
            id va = [dic objectForKey:key];
            if([va isKindOfClass:[NSArray class]])
            {
                NSArray* vlist = va;
                for (int j=0; j<vlist.count; j++) {
                    id subvalue = [vlist objectAtIndex:j];
                    if(wherekey.length > 0)
                    {
                        if(j >0)
                        {
                            [wherekey appendFormat:@" or %@ = ? ",key];
                        }
                        else{
                            [wherekey appendFormat:@" and %@ = ? ",key];
                        }
                    }
                    else
                    {
                        [wherekey appendFormat:@" %@ = ? ",key];
                    }
                    [values addObject:subvalue];
                }
            }
            else
            {
                if(wherekey.length > 0)
                {
                    [wherekey appendFormat:@" and %@ = ? ",key];
                }
                else
                {
                    [wherekey appendFormat:@" %@ = ? ",key];
                }
                [values addObject:va];
            }
            
        }
    }
    return wherekey;
}
-(void)deleteToDBWithWhereDic:(NSDictionary *)where callback:(void (^)(BOOL))block
{
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         NSMutableArray* values = [NSMutableArray arrayWithCapacity:6];
         NSString* wherekey = [self dictionaryToSqlWhere:where andValues:values];
         NSString* delete = [NSString stringWithFormat:@"DELETE FROM %@ where %@",self.tableName,wherekey];
         BOOL result = [db executeUpdate:delete withArgumentsInArray:values];
         if(block != nil)
         {
             block(result);
         }
     }];
}

-(void)clearTableData
{
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         NSString* delete = [NSString stringWithFormat:@"DELETE FROM %@",self.tableName];
         [db executeUpdate:delete];
     }];
}

-(void)isExistsModel:(NSObject<MHDataBaseModelInteface>*)model callback:(void(^)(BOOL))block{
    //如果有rowid 就肯定存在
    [self isExistsWithWhere:[NSString stringWithFormat:@"%@ = '%@'",model.primaryKey,[self safetyGetModel:model valueKey:model.primaryKey]] callback:block];
}

-(void)isExistsWithWhere:(NSString *)where callback:(void (^)(BOOL))block
{
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         //rowid 就不判断了
         NSString* rowCountSql = [NSString stringWithFormat:@"select count(rowid) from %@ where %@",self.tableName,where];
         FMResultSet* resultSet = [db executeQuery:rowCountSql];
         [resultSet next];
         int result =  [resultSet intForColumnIndex:0];
         [resultSet close];
         BOOL exists = (result != 0);
         if(block != nil)
         {
             block(exists);
         }
     }];
}

-(id)safetyGetModel:(NSObject<MHDataBaseModelInteface>*) model valueKey:(NSString*)valueKey
{
    id value = [model valueForKey:valueKey];
    if(value == nil)
    {
        return @"";
    }
    return value;
}

const static NSString* normaltypestring = @"floatdoublelongcharshort";
const static NSString* blobtypestring = @"NSDataUIImage";
+(NSString *)toDBType:(NSString *)type
{
    if([type isEqualToString:@"int"])
    {
        return MHSQLInt;
    }
    if ([normaltypestring rangeOfString:type].location != NSNotFound) {
        return MHSQLDouble;
    }
    if ([blobtypestring rangeOfString:type].location != NSNotFound) {
        return MHSQLBlob;
    }
    return MHSQLText;
}
#pragma mark-

#pragma mark - private msd
- (NSDateFormatter*)getDateFormat
{
    static  NSDateFormatter* formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    });
    return formatter;
}

//把Date 转换成String
- (NSString*)stringWithDate:(NSDate *)date
{
    NSDateFormatter* formatter = [self getDateFormat];
    NSString* datestr = [formatter stringFromDate:date];
    return datestr;
}

- (NSDate *)dateWithString:(NSString *)str
{
    NSDateFormatter* formatter = [self getDateFormat];
    NSDate* date = [formatter dateFromString:str];
    return date;
}

@end

