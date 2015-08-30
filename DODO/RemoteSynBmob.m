//
//  RemoteSynBmob.m
//  DODO
//
//  Created by ld on 15/8/22.
//  Copyright (c) 2015年 lvdong. All rights reserved.
//

#import "RemoteSynBmob.h"


@implementation RemoteSynBmob

+ (BOOL)Signin:(UserTable *)user {
    __block BOOL returnbool;
    [BmobUser loginWithUsernameInBackground:user.UserID password:user.UserPass block:^(BmobUser *user, NSError *error) {
        if (error != nil) {
            returnbool = NO;
        }
        else {
            returnbool = YES;
        }
    }];
    return returnbool;
}

+ (BOOL)InsertTaskStoreToBmob:(TaskStoreTable *)task {
    __block BOOL returnbool;
    BmobObject *taskstore = [BmobObject objectWithClassName:@"taskstore"];
    [taskstore setObject:task.TaskID forKey:@"task_ID"];
    [taskstore setObject:task.TaskName forKey:@"task_name"];
    [taskstore setObject:task.TaskNote forKey:@"task_note"];
    [taskstore setObject:task.TaskOwner forKey:@"task_owner"];
    [taskstore setObject:task.TaskGroup forKey:@"task_group"];
    [taskstore setObject:task.TaskRoundSign forKey:@"task_roundsign"];
    [taskstore setObject:task.TaskRound forKey:@"task_round"];
    [taskstore setObject:task.TaskCount forKey:@"task_count"];
    [taskstore setObject:task.TaskType forKey:@"task_type"];
    [taskstore setObject:task.TaskBegdate forKey:@"task_begdate"];
    [taskstore setObject:task.TaskEnddate forKey:@"task_enddate"];
    [taskstore setObject:task.TaskBegtime forKey:@"task_begtime"];
    [taskstore setObject:task.TaskClock forKey:@"task_clock"];
    [taskstore setObject:task.TaskResource forKey:@"task_resource"];
    [taskstore setObject:task.TaskTimeFlag forKey:@"task_timeflag"];
    [taskstore setObject:task.TaskDoRate forKey:@"task_dorate"];
    [taskstore setObject:task.TaskLastDone forKey:@"task_lastdone"];
    [taskstore setObject:task.TaskStatus forKey:@"task_status"];
    [taskstore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        returnbool = isSuccessful;
    }];
    return returnbool;
}

+ (BOOL)DeleteTaskStoreToBmob:(TaskStoreTable *)task {
    __block BOOL returnbool;
    BmobObject *taskstore = [BmobObject objectWithoutDatatWithClassName:@"taskstore" objectId:task.TaskID ];
    [taskstore deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        returnbool = isSuccessful;
    }];
    return returnbool;
}

+ (NSString *)SynTasksFromBmob {
    
    TaskStatusTable *taskstatus = [LocalPersistOC getTaskStatus];
    
    NSString *timeflag = taskstatus.StatusTaskDown;
    
    int downnum = 0;
    int upnum = 0;
    double newtimeflag=0;
    
    NSArray *userlist = [LocalPersistOC getUserList:@"select * from userlist where user_localsign='1'"];
    UserTable *luser = [userlist objectAtIndex:0];
    
    BmobQuery *bquery = [[BmobQuery alloc] init];
    NSString *bql = [NSString stringWithFormat:@"select * from taskstore where task_timeflag>'%@' and (task_owner='%@' or task_resource='%@')",timeflag,luser.UserID,luser.UserID];

    
    __block NSMutableArray *tasklist = [[NSMutableArray alloc] initWithCapacity:1];
    [bquery queryInBackgroundWithBQL:bql block:^(BQLQueryResult *result, NSError *error) {
        for (BmobObject *obj in result.resultsAry) {
            TaskStoreTable *task = [[TaskStoreTable alloc] init];
            task.TaskID  = [obj objectForKey:@"task_ID"];
            task.TaskName  = [obj objectForKey:@"task_name"];
            task.TaskNote  = [obj objectForKey:@"task_note"];
            task.TaskOwner  = [obj objectForKey:@"task_owner"];
            task.TaskGroup  = [obj objectForKey:@"task_group"];
            task.TaskRoundSign  = [obj objectForKey:@"task_roundsign"];
            task.TaskRound  = [obj objectForKey:@"task_round"];
            task.TaskCount  = [obj objectForKey:@"task_count"];
            task.TaskType  = [obj objectForKey:@"task_type"];
            task.TaskBegdate  = [obj objectForKey:@"task_begdate"];
            task.TaskEnddate  = [obj objectForKey:@"task_enddate"];
            task.TaskBegtime  = [obj objectForKey:@"task_begtime"];
            task.TaskClock  = [obj objectForKey:@"task_clock"];
            task.TaskResource  = [obj objectForKey:@"task_resource"];
            task.TaskTimeFlag  = [obj objectForKey:@"task_timeflag"];
            task.TaskDoRate  = [obj objectForKey:@"task_dorate"];
            task.TaskLastDone  = [obj objectForKey:@"task_lastdone"];
            task.TaskStatus  = [obj objectForKey:@"task_status"];
            [tasklist addObject:task];
        }
        
    }];
    
    
    NSMutableArray *localtasklist = [NSMutableArray arrayWithArray:[LocalPersistOC getUserList:[NSString stringWithFormat:@"select * from taskstore where task_timeflag>'%@'",timeflag]]];
    for ( TaskStoreTable *rtask in tasklist ) {
        newtimeflag = (newtimeflag > rtask.TaskTimeFlag.doubleValue) ? newtimeflag : rtask.TaskTimeFlag.doubleValue;
        int localhas = 0;
        for ( TaskStoreTable *ltask in localtasklist ) {
            if (rtask.TaskID == ltask.TaskID) {
                localhas = 1;
                if (rtask.TaskTimeFlag.floatValue > ltask.TaskTimeFlag.floatValue) {
                    [LocalPersistOC deleteTask:ltask];
                    [LocalPersistOC saveNewTask:rtask];
                    downnum++;
                }
                else if (rtask.TaskTimeFlag.floatValue < ltask.TaskTimeFlag.floatValue)
                {
                    [RemoteSynBmob DeleteTaskStoreToBmob:rtask];
                    [RemoteSynBmob InsertTaskStoreToBmob:ltask];
                    upnum++;
                }
            }
        }
        if (localhas == 0) {
            [LocalPersistOC saveNewTask:rtask];
            downnum++;
        }
    }
    for ( TaskStoreTable *ltask in localtasklist ) {
        newtimeflag = (newtimeflag > ltask.TaskTimeFlag.doubleValue) ? newtimeflag : ltask.TaskTimeFlag.doubleValue;
        int remotehas = 0;
        for ( TaskStoreTable *rtask in tasklist ) {
            if (rtask.TaskID == ltask.TaskID) {
                remotehas = 1;
            }
        }
        if (remotehas == 0) {
            [RemoteSynBmob InsertTaskStoreToBmob:ltask];
            upnum++;
        }
    }
    
    taskstatus.StatusTaskDown = [NSString stringWithFormat:@"%f",newtimeflag ];
    [LocalPersistOC updateTaskStatus:taskstatus];
    
    return [NSString stringWithFormat:@"共上传%i条，下载%i条",upnum,downnum];
}

@end
