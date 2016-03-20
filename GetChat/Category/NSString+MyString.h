//
//  NSString+MyString.h
//  HuiXin
//
//  Created by apple on 13-12-11.
//  Copyright (c) 2013年 惠卡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MyString)

+ (NSString *)stringBySpaceTrim:(NSString *)string;

/// 替换@为#
- (NSString *)replacingAtWithOctothorpe;
- (NSString *)replacingOctothorpeWithAt;

/// 将回车转成空格
- (NSString *)replacingEnterWithNull;

/// 是否包含汉字
+ (BOOL)containsChinese:(NSString *)string;

+ (NSString *)stringByNull:(NSString*)string;
+ (BOOL)isNull:(NSString *)string;
+ (BOOL)isEmptyAfterSpaceTrim:(NSString *)string;

- (BOOL)isBlank;

/// 判断是否纯数字
+ (BOOL)isPureInt:(NSString*)string;

/// 判断浮点型
+ (BOOL)isPureFloat:(NSString*)string;

/// 手机号添加空格
+ (NSString *)addBlank:(NSString *)phone;

#pragma mark - float型字符串： 数据处理

/// 浮点型数据不四舍五入
+(NSString *)notRounding:(NSString *)price afterPoint:(NSInteger )position;

///  转化成标准数字形式 3位一个","
+(NSString *)convertToDecimalStyle:(NSString *)aString;

///数字整数部分三位加一个逗号，与保留小数点
+(NSString *)convertToDecimalStyle:(NSString *)aString afterPiont:(NSInteger )pointNum;

///数字整数部分三位加一个逗号，与保留小数点 且解决浮点数据小数部分异常问题：列如，5.6887 8 变为 5.6887 79.
+ (NSString *)convertToDecimalStyleWithDouble:(double)d afterPiont:(NSInteger )pointNum;

///数值转换
+ (NSString *)numericalConversion:(NSInteger)num;

///密码限制：字母、数字、特殊字母（除空格），两种以上类型组成
- (BOOL)checkPasswordLimit;
@end
