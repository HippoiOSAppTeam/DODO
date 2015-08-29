//
//  TaskLogTable.h
//  DODO
//
//  Created by ld on 15/8/29.
//  Copyright (c) 2015年 lvdong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskLogTable : NSObject

@property(nonatomic,weak) NSString * LogID;
@property(nonatomic,weak) NSString * LogDate;
@property(nonatomic,weak) NSString * TaskID;
@property(nonatomic,weak) NSString * TaskOwner;
@property(nonatomic,weak) NSString * TaskGroup;
@property(nonatomic,weak) NSString * TaskResource;
@property(nonatomic,weak) NSString * DoBegtime;
@property(nonatomic,weak) NSString * DoEndtime;
@property(nonatomic,weak) NSNumber * DoTimer;
@property(nonatomic,weak) NSNumber * DoRate;
@property(nonatomic,weak) NSString * LogTimeFlag;

@end
