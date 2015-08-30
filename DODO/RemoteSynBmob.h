//
//  RemoteSynBmob.h
//  DODO
//
//  Created by ld on 15/8/22.
//  Copyright (c) 2015年 lvdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BmobSDK/Bmob.h"
#import "TaskStoreTable.h"
#import "UserTable.h"
#import "LocalPersistOC.h"
#import "TaskStatusTable.h"

@interface RemoteSynBmob : NSObject

+ (BOOL)InsertTaskStoreToBmob:(TaskStoreTable *) task;

//同步服务器后端与本地所有task数据，包括owner和resource为本地用户的任务列表。
+ (NSString *)SynTasksFromBmob;

+ (BOOL)RegistNewUserToBmob:(UserTable *) user;

+ (BOOL)Signin:(UserTable *) user;

@end
