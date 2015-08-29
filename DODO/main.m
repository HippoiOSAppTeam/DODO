//
//  main.m
//  DODO
//
//  Created by ld on 15/8/22.
//  Copyright (c) 2015年 lvdong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BmobSDK/Bmob.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSString *appkey = @"6a4a6071385b9b66a4646218d5b2accf";
        [Bmob registerWithAppKey:appkey];
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
