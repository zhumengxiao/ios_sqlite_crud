//
//  PccpaDBHelper.m
//  iOSCrud
//
//  Created by 朱梦晓 on 15-10-8.
//  Copyright (c) 2015年 Pccpa. All rights reserved.
//

#import "PccpaDBHelper.h"
#import "sqlite3.h"

@implementation PccpaDBHelper

-(NSString *) getDataBaseFileName
{
    static NSString * defaultName =@"mydatabase.sqlite";
    NSString * fileName = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",defaultName];
    
    // if the databaseFile doesn't exit ,create table..
    NSFileManager * fm =[NSFileManager defaultManager];
    if (![fm fileExistsAtPath:fileName]) {
        [self createTable];
    }
    return  fileName;
}

-(BOOL) createTable
{
    NSString * fileName = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",@"mydatabase.sqlite"];
    sqlite3 * sqlite = nil;
    sqlite3_stmt * stmt = nil;
    int res= sqlite3_open( [fileName UTF8String], &sqlite);
    static NSString * createsql = @"CREATE TABLE if not exists Task ( taskName VARCHAR, ID INTEGER PRIMARY KEY AUTOINCREMENT)";
    sqlite3_prepare_v2(sqlite, [createsql UTF8String], -1, &stmt, nil);
    sqlite3_step(stmt);
    
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    return YES;
}

-(BOOL) addTask:(PccpaTask *)task
{

    
    sqlite3 * sqlite = nil;
    sqlite3_stmt * stmt = nil;
    int res= sqlite3_open( [[self getDataBaseFileName] UTF8String], &sqlite);
    if(res!=SQLITE_OK)
        NSLog(@"open the db failed");
    
    static NSString * insertsql = @"insert into Task (taskName) values(?)";
    sqlite3_prepare_v2(sqlite, [insertsql UTF8String], -1, &stmt, nil);
    sqlite3_bind_text(stmt, 1, [task.taskName UTF8String], -1, SQLITE_TRANSIENT);
    
    sqlite3_step(stmt);
    
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    
    return YES;
}
-(NSMutableArray *) getTaskList
{
    NSMutableArray * array = [NSMutableArray array];
    
    sqlite3 * sqlite = nil;
    sqlite3_stmt * stmt = nil;
    int res= sqlite3_open( [[self getDataBaseFileName] UTF8String], &sqlite);
    if(res!=SQLITE_OK)
        NSLog(@"open the db failed");
    
    static NSString * selectsql = @"select * from Task";
    sqlite3_prepare_v2(sqlite, [selectsql UTF8String], -1, &stmt, nil);
    
    while (sqlite3_step(stmt)==SQLITE_ROW) {
        PccpaTask * task = [[PccpaTask alloc]init];
        task.taskName =[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
        task.ID =sqlite3_column_int(stmt, 1);
        [array addObject:task];
    }
    
    return array;
}
-(BOOL) deleteTask:(PccpaTask *)task
{
    sqlite3 * sqlite = nil;
    sqlite3_stmt * stmt = nil;
    int res= sqlite3_open( [[self getDataBaseFileName] UTF8String], &sqlite);
    if(res!=SQLITE_OK)
        NSLog(@"open the db failed");
    
    static NSString * insertsql = @"delete from Task where ID= ?";
    sqlite3_prepare_v2(sqlite, [insertsql UTF8String], -1, &stmt, nil);
    sqlite3_bind_int(stmt, 1, task.ID);
    sqlite3_step(stmt);
    
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    
    return YES;

}

-(BOOL) updateTask:(PccpaTask *)task
{
    sqlite3 * sqlite = nil;
    sqlite3_stmt * stmt = nil;
    int res= sqlite3_open( [[self getDataBaseFileName] UTF8String], &sqlite);
    if(res!=SQLITE_OK)
        NSLog(@"open the db failed");
    
    static NSString * insertsql = @"update Task set TaskName= ? where ID= ?";
    sqlite3_prepare_v2(sqlite, [insertsql UTF8String], -1, &stmt, nil);
    sqlite3_bind_text(stmt, 1, [task.taskName UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(stmt, 2, task.ID);
    sqlite3_step(stmt);
    
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);

    
    return YES;
}

@end
