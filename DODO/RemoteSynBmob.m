//
//  RemoteSynBmob.m
//  DODO
//
//  Created by ld on 15/8/22.
//  Copyright (c) 2015年 lvdong. All rights reserved.
//

#import "RemoteSynBmob.h"


@implementation RemoteSynBmob

- (BOOL)Signin:(UserTable *)user {
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

- (BOOL)InsertTaskStoreToBmob:(TaskStoreTable *)task {
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

- (NSArray *)DownloadTasksFromBmob:(NSString *)timeflag {
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"taskstore"];
    [bquery whereKey:@"task_timeflag" greaterThan:timeflag];
    __block NSMutableArray *tasklist = [[NSMutableArray alloc] initWithCapacity:1];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
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
    return tasklist;
}

@end
