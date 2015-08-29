//
//  LocalPersistOC.m
//  DODO
//
//  Created by ld on 15/8/29.
//  Copyright (c) 2015年 lvdong. All rights reserved.
//

#import "LocalPersistOC.h"


@implementation LocalPersistOC

+ (BOOL)saveNewTask:(TaskStoreTable *)task {
    LocalPersistSQLite *ls = [[LocalPersistSQLite alloc] init];
    return [ls saveNewTask:task];
}

+ (NSArray *)getTaskList:(NSString *)sql {
    LocalPersistSQLite *ls = [[LocalPersistSQLite alloc] init];
    return [ls getTaskList:sql];
}

+ (BOOL)insertNewUser:(UserTable *) tuser {
    LocalPersistSQLite *ls = [[LocalPersistSQLite alloc] init];
    return [ls insertNewUser:tuser];
}

+ (NSArray *)getUserList:(NSString *) sql {
    LocalPersistSQLite *ls = [[LocalPersistSQLite alloc] init];
    return [ls getUserList:sql];
}

+ (BOOL)updateTaskNow:(TaskNowTable *) tasknow {
    LocalPersistSQLite *ls = [[LocalPersistSQLite alloc] init];
    return [ls updateTaskNow:tasknow];
}

+ (TaskNowTable *)getTaskNow {
    LocalPersistSQLite *ls = [[LocalPersistSQLite alloc] init];
    return [ls getTaskNow];
}

+ (BOOL)insertTaskLog:(TaskLogTable *) tasklog {
    LocalPersistSQLite *ls = [[LocalPersistSQLite alloc] init];
    return [ls insertTaskLog:tasklog];
}

+ (BOOL)updateTaskStatus:(TaskStatusTable *) taskstatus {
    LocalPersistSQLite *ls = [[LocalPersistSQLite alloc] init];
    return [ls updateTaskStatus:taskstatus];
}

+ (TaskStatusTable *)getTaskStatus {
    LocalPersistSQLite *ls = [[LocalPersistSQLite alloc] init];
    return [ls getTaskStatus];
}
@end
