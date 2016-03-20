//
//  HUDManager.h
//  test_login
//
//  Created by liguangluo on 16/1/4.
//  Copyright © 2016年 liguangluo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface HUDManager : NSObject <MBProgressHUDDelegate>

/**
 @author 杨旭, 14-11-26 12:11:16
 @brief 显示默认模式的加载视图,添加到target,阻塞操作[阻塞页面不阻塞导航栏可用此方法设置]
 @param aMessage 加载视图显示的文字信息
 @param target   加载视图被添加到该视图上, 如果target=nil,则被添加到window上
 */
+ (void)showHUDWithMessage:(NSString *)aMessage onTarget:(UIView *)target;

/// 设置方法:此方法默认加载到window上
+ (void)showHUD:(MBProgressHUDMode)mode hide:(BOOL)autoHide afterDelay:(NSTimeInterval)timeDelay enabled:(BOOL)autoEnabled message:(NSString *)aMessage;


/// 隐藏
+ (void)hiddenHUD;

@end
