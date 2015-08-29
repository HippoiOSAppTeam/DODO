//
//  LocalPersistOC.h
//  DODO
//
//  Created by ld on 15/8/29.
//  Copyright (c) 2015年 lvdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DODO-Swift.h"

@interface LocalPersistOC : NSObject

+ (BOOL)saveNewTask:(TaskStoreTable *)task;
+ (NSArray *)getTaskList:(NSString *)sql;
+ (BOOL)insertNewUser:(UserTable *) tuser ;
+ (NSArray *)getUserList:(NSString *) sql ;
+ (BOOL)updateTaskNow:(TaskNowTable *) tasknow;
+ (TaskNowTable *)getTaskNow;
+ (BOOL)insertTaskLog:(TaskLogTable *) tasklog;
+ (BOOL)updateTaskStatus:(TaskStatusTable *) taskstatus;
+ (TaskStatusTable *)getTaskStatus;

@end
