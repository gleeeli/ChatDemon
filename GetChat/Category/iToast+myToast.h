//
//  iToast+myToast.h
//  HKMember
//
//  Created by 文俊 on 14-4-26.
//  Copyright (c) 2014年 惠卡. All rights reserved.
//

#import "iToast.h"

@interface iToast (myToast)

+ (iToast *)alertWithTitle:(NSString *)title;

+ (iToast *)alertWithTitleCenter:(NSString *)title;

/// 隐藏
+ (void)hiddenIToast;

@end
