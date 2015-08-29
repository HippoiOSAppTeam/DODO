//
//  LocalPersistSQLite.swift
//  DODO
//
//  Created by ld on 15/8/29.
//  Copyright (c) 2015年 lvdong. All rights reserved.
//

import UIKit

class LocalPersistSQLite: NSObject {
    let db=SQLiteDB.sharedInstance();
    
    func saveNewTask(task : TaskStoreTable) -> Bool {
        
        let sql = "insert into taskstore(task_ID,task_name,task_note,task_owner,task_group,task_roundsign,task_round,task_count,task_type,task_begdate,task_enddate,task_begtime,task_clock,task_resource,task_timeflag,task_dorate,task_lastdone,task_status)  values('\(task.TaskID)','\(task.TaskName)','\(task.TaskNote)','\(task.TaskOwner)','\(task.TaskGroup)','\(task.TaskRoundSign)','\(task.TaskRound)',\(task.TaskCount.intValue),'\(task.TaskType)','\(task.TaskBegdate)','\(task.TaskEnddate)','\(task.TaskBegtime)','\(task.TaskClock)',\(task.TaskResource),'\(task.TaskTimeFlag)',\(task.TaskDoRate.floatValue),'\(task.TaskLastDone)','\(task.TaskStatus)')"
        let ret = db.execute(sql)
        if(ret > 0)
        {
            return true
        }
        return false
    }
    
    func getTaskList(sql : String) -> Array<TaskStoreTable>? {
        var tasklist : Array<TaskStoreTable>? = Array<TaskStoreTable>()
        var sqlresult = db.query(sql)
        if(sqlresult.count > 0)
        {
            for(var i=0; i<sqlresult.count; i++)
            {
                var task:TaskStoreTable = TaskStoreTable();
                task.TaskID = sqlresult[i]["task_ID"]!.asString()
                task.TaskName = sqlresult[i]["task_name"]!.asString()
                task.TaskNote = sqlresult[i]["task_note"]!.asString()
                task.TaskOwner = sqlresult[i]["task_owner"]!.asString()
                task.TaskGroup = sqlresult[i]["task_group"]!.asString()
                task.TaskRoundSign = sqlresult[i]["task_roundsign"]!.asString()
                task.TaskRound = sqlresult[i]["task_round"]!.asString()
                task.TaskCount = sqlresult[i]["task_count"]!.asInt()
                task.TaskType = sqlresult[i]["task_type"]!.asString()
                task.TaskBegdate = sqlresult[i]["task_begdate"]!.asString()
                task.TaskEnddate = sqlresult[i]["task_enddate"]!.asString()
                task.TaskBegtime = sqlresult[i]["task_begtime"]!.asString()
                task.TaskClock = sqlresult[i]["task_clock"]!.asString()
                task.TaskResource = sqlresult[i]["task_resource"]!.asString()
                task.TaskTimeFlag = sqlresult[i]["task_timeflag"]!.asString()
                task.TaskDoRate = sqlresult[i]["task_dorate"]!.asDouble()
                task.TaskLastDone = sqlresult[i]["task_lastdone"]!.asString()
                task.TaskStatus = sqlresult[i]["task_status"]!.asString()
                tasklist?.append(task);
            }
        }
        return tasklist
    }
    
    func insertNewUser(tuser : UserTable) -> Bool {
        let sql = "insert into userlist values('\(tuser.UserID)','\(tuser.UserName)','\(tuser.UserPass)','\(tuser.UserLocalSign)')"
        db.execute(sql)
        return true;
    }
    
    func getUserList(sql : String) -> Array<UserTable>? {
        var userlist : Array<UserTable>? = Array<UserTable>()
        var sqlresult = db.query(sql)
        if(sqlresult.count > 0)
        {
            for(var i=0; i<sqlresult.count; i++)
            {
                var tuser:UserTable = UserTable()
                tuser.UserID = sqlresult[i]["user_ID"]!.asString()
                tuser.UserName = sqlresult[i]["user_name"]!.asString()
                tuser.UserPass = sqlresult[i]["user_pwd"]!.asString()
                tuser.UserLocalSign = sqlresult[i]["user_localsign"]!.asString()
                userlist?.append(tuser);
            }
        }
        return userlist
    }
    
    func updateTaskNow(tasknow : TaskNowTable) -> Bool {
        db.execute("delete * from tasknow")
        let sql = "insert into tasknow(task_ID,task_date,task_begtime,task_endtime) values(?,?,?,?)"
        let params = [tasknow.TaskID,tasknow.TaskDate,tasknow.TaskBegtime,tasknow.TaskEndtime]
        let ret = db.execute(sql, parameters: params);
        if(ret > 0)
        {
            return true
        }
        return false
    }
    
    func getTaskNow() ->TaskNowTable? {
        var tasknow : TaskNowTable? = TaskNowTable?()
        let sqlresult = db.query("select * from tasknow", parameters: nil);
        if(sqlresult.count>1)
        {
            tasknow?.TaskID = sqlresult[0]["task_ID"]?.asString();
            tasknow?.TaskDate = sqlresult[0]["task_date"]?.asString()
            tasknow?.TaskBegtime = sqlresult[0]["tsak_begtime"]?.asString()
            tasknow?.TaskEndtime = sqlresult[0]["task_endtime"]?.asString()
        }
        return tasknow
    }
    
    func insertTaskLog(tasklog : TaskLogTable) ->Bool {
        let sql = "insert into tasklog(log_ID,log_date,task_ID,task_owner,task_group,task_resource,do_begtime,do_endtime,do_timer,do_rate,log_timeflag)"
        let params = [tasklog.LogID,tasklog.LogDate,tasklog.TaskID,tasklog.TaskOwner,tasklog.TaskGroup,tasklog.TaskResource,tasklog.DoBegtime,tasklog.DoEndtime,tasklog.DoTimer,tasklog.DoRate,tasklog.LogTimeFlag];
        let ret = db.execute(sql, parameters: params)
        if(ret > 0)
        {
            return true
        }
        return false
    }
    
    func updateTaskStatus(taskstatus : TaskStatusTable ) ->Bool {
        return true
    }
    
    func getTaskStatus() -> TaskStatusTable? {
        let taskstatus : TaskStatusTable? = TaskStatusTable?()
        
        return taskstatus;
    }
}
