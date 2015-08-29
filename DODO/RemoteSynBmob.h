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

@interface RemoteSynBmob : NSObject

- (BOOL)InsertTaskStoreToBmob:(TaskStoreTable *) task;
- (NSArray *)DownloadTasksFromBmob:(NSString *) timeflag;
- (BOOL)RegistNewUserToBmob:(UserTable *) user;
- (BOOL)Signin:(UserTable *) user;

@end
