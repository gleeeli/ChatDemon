//
//  Common_define.h
//  testMkNetWork
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 youshixiu. All rights reserved.
//

#import "LLMyHeader.h"
#import "Common_limit.h"
#import "Common_network.h"

#import "iToast.h"
#import "iToast+myToast.h"
#import "HUDManager.h"

//常用
#import "LLXMPPManager.h"
#import "UIInitMethod.h"
#import "NSString+MyString.h"
#import "UserModel.h"

#ifndef Common_define_h
#define Common_define_h

#pragma mark - weakSelf

/// block self
#define kSelfWeak __weak typeof(self) weakSelf = self
#define kSelfStrong __strong __typeof__(self) strongSelf = weakSelf

#pragma mark - Height/Width

/// Local
#define kLocalizedString(key) NSLocalizedString(key, nil)

/// Height/Width

#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       ([UIScreen mainScreen].bounds.size.height - 20.0)
#define kAllHeight          [UIScreen mainScreen].bounds.size.height
#define kBodyHeight         ([UIScreen mainScreen].bounds.size.height - 64.0)

#define kTabbarHeight       49
#define kSearchBarHeight    45
#define kStatusBarHeight    20
#define kNavigationHeight   44

// 方便写接口
#define ParamsDic dic
#define CreateParamsDic NSMutableDictionary *ParamsDic = [NSMutableDictionary dictionary]
#define DicObjectSet(obj,key) [ParamsDic setObject:obj forKey:key]
#define DicValueSet(value,key) [ParamsDic setValue:value forKey:key]

#pragma mark - System  Device

/// System  Device
#define ISiPhone    [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define ISiPad      [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define ISiPhone5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#pragma mark - system version

/// system version
#define ISIOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) // IOS6的系统
#define ISIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) // IOS7的系统
#define ISIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) // IOS8的系统

/// Dlog
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif


#pragma mark 网络交互提示语
#define kNetworkWaitting @"请稍候..."

#endif /* Common_define_h */
