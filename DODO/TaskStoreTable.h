//
//  TaskStoreTable.h
//  DODO
//
//  Created by ld on 15/8/22.
//  Copyright (c) 2015年 lvdong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskStoreTable : NSObject

@property(nonatomic,weak) NSString * TaskID;
@property(nonatomic,weak) NSString * TaskName;
@property(nonatomic,weak) NSString * TaskNote;
@property(nonatomic,weak) NSString * TaskOwner;
@property(nonatomic,weak) NSString * TaskGroup;
@property(nonatomic,weak) NSString * TaskRoundSign;
@property(nonatomic,weak) NSString * TaskRound;
@property(nonatomic,weak) NSNumber * TaskCount;
@property(nonatomic,weak) NSString * TaskType;
@property(nonatomic,weak) NSString * TaskBegdate;
@property(nonatomic,weak) NSString * TaskEnddate;
@property(nonatomic,weak) NSString * TaskBegtime;
@property(nonatomic,weak) NSString * TaskClock;
@property(nonatomic,weak) NSString * TaskResource;
@property(nonatomic,weak) NSString * TaskTimeFlag;
@property(nonatomic,weak) NSNumber * TaskDoRate;
@property(nonatomic,weak) NSString * TaskLastDone;
@property(nonatomic,weak) NSString * TaskStatus;

@end
