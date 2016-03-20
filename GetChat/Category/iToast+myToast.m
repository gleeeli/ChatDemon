//
//  iToast+myToast.m
//  HKMember
//
//  Created by 文俊 on 14-4-26.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import "iToast+myToast.h"

static iToast *staticIToast; // 定义表态变量 张绍裕 20140701

@implementation iToast (myToast)

// 实例化iToast
+ (iToast *)alertWithTitle:(NSString *)title
{
    staticIToast = [iToast makeText:title ];
    [iToastSettings getSharedSettings].postition = CGPointMake(kScreenWidth, 120);
    [staticIToast setGravity:iToastGravityTop
           offsetLeft:0
            offsetTop:120];
	[staticIToast show];
	return staticIToast;
}

+ (iToast *)alertWithTitleCenter:(NSString *)title
{
    staticIToast = [iToast makeText:title ];
    [iToastSettings getSharedSettings].postition = CGPointMake(kScreenWidth, 120);
    [staticIToast setGravity:iToastGravityCenter
           offsetLeft:0
            offsetTop:120];
	[staticIToast show];
	return staticIToast;
}

+ (void)hiddenIToast
{
    [staticIToast hidden];
}

@end
