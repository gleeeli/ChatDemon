//
//  NSString+MyString.m
//  HuiXin
//
//  Created by apple on 13-12-11.
//  Copyright (c) 2013年 惠卡. All rights reserved.
//

#import "NSString+MyString.h"

@implementation NSString (MyString)

// 去空格
+ (NSString *)stringBySpaceTrim:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)replacingAtWithOctothorpe
{
    return [self stringByReplacingOccurrencesOfString:@"@" withString:@"#"];
}

- (NSString *)replacingOctothorpeWithAt
{
    return [self stringByReplacingOccurrencesOfString:@"#" withString:@"@"];
}

// 将回车转成空格
- (NSString *)replacingEnterWithNull
{
    return [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

// 是否包含汉字
+ (BOOL)containsChinese:(NSString *)string
{
    for (int i = 0; i < [string length]; i++)
    {
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    
    return NO;
}

// 回车转@""
+ (NSString *)stringByEnter:(NSString*)string
{
    for (int i = 0; i < [string length]; i++)
    {
        int a = [string characterAtIndex:i];
        if (a == 0x0d)
        {
            a = 0x20;
        }
    }
    return string;
}

// null转@""
+ (NSString*)stringByNull:(NSString*)string
{
    if (!string)
    {
        return @"";
    }
    return string;
}

// null或者@""都返回yes
+ (BOOL)isNull:(NSString *)string
{
    if (!string || [string isEqualToString:@""])
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)isBlank
{
    if([[self stringByStrippingWhitespace] length] == 0)
    {
        return YES;
    }
    
    return NO;
}

- (NSString *)stringByStrippingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

// 判断是否为整形：
+ (BOOL)isPureInt:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

// 判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)isEmptyAfterSpaceTrim:(NSString *)string
{
    NSString *str = [self stringBySpaceTrim:string];
    if (str.length == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 手机号添加空格
+ (NSString *)addBlank:(NSString *)phone
{
    // 去掉-
    phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSMutableString *string = [NSMutableString string];
    for (int i = 0;i< phone.length; i++)
    {
        if (i == 2 ||i == 6)
        {
            [string appendString:[NSString stringWithFormat:@"%@ ",[phone substringWithRange:NSMakeRange(i, 1)]]];
        }
        else
        {
            [string appendString:[phone substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return string;
}

#pragma mark - float型字符串： 数据处理

// 浮点型数据不四舍五入
+ (NSString *)notRounding:(NSString *)price afterPoint:(NSInteger)position
{
    if ([price isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)price;
        ;
        price = [NSString stringWithFormat:@"%lf",[number doubleValue]];
    }
    
    if ([price isKindOfClass:[NSNumber class]] && price) {
        price = [NSString stringWithFormat:@"%@",price];
    }else{
        if ([NSString isNull:price]) {
            return nil;
        }
    }
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal = nil;
    NSDecimalNumber *roundedOunces = nil;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithString:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:[NSString formatStringWithPiontNum:position],[roundedOunces doubleValue]];
}

///浮点型:保留几位小数 格式字符串
+ (NSString *)formatStringWithPiontNum:(NSInteger)pointNum
{
    NSString *format;
    switch (pointNum) {
        case 0:
            format = @"%f";
            break;
        default:
            format = [NSString stringWithFormat: @"%@%lu%@",@"%.",(unsigned long)pointNum,@"f"];
            break;
    }
    return format;
}

///  转化成标准数字形式 3位一个","
+(NSString *)convertToDecimalStyle:(NSString *)aString{
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    currencyFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    NSString *myString = [currencyFormatter stringFromNumber:[NSNumber numberWithDouble:[aString doubleValue]]];
    return myString;
}

///数字整数部分加逗号与保留小数点
+(NSString *)convertToDecimalStyle:(NSString *)aString afterPiont:(NSInteger )pointNum
{
    //截取两位小数
    aString = [NSString  notRounding:aString afterPoint:pointNum];
    float f = [aString floatValue];
    if (f >0)
    {
        //加逗号
        NSString *tempString = [NSString convertToDecimalStyle:aString];
        
        //拼0
        tempString = [NSString appendZero:tempString afterPoint:pointNum];

        return tempString;
    }
    else
    {
        return aString;
    }
    
}

///小数点后0不足，拼足0
+ (NSString *)appendZero:(NSString *)tempString afterPoint:(NSInteger)pointNum
{
    //如果是整数且小数部分为0，则补足0
    NSRange range = [tempString rangeOfString:@"."];
    if (range.location == NSNotFound)
    {//整数
        tempString = [tempString stringByAppendingString:@"."];
        for (int i=0; i<pointNum; i++)
        {
            tempString = [tempString stringByAppendingString:@"0"];
        }
    }
    else
    {//小数
        NSRange range = [tempString rangeOfString:@"."];
        NSString *floatPartString = [tempString substringFromIndex:range.location+1];
        if (floatPartString.length < pointNum)
        {
            for (int i=0; i<(pointNum - floatPartString.length); i++)
            {
                tempString = [tempString stringByAppendingString:@"0"];
            }
        }
    }
    return tempString;
}
///数字整数部分三位加一个逗号，与保留小数点 且解决浮点数据小数部分异常问题：列如，5.6887 8 变为 5.6887 79.
+ (NSString *)convertToDecimalStyleWithDouble:(double)d afterPiont:(NSInteger )pointNum
{
    NSString *string = [NSString stringWithFormat:@"%.6lf",d];
    return [NSString convertToDecimalStyle:string afterPiont:pointNum];
}
///数值转换
+(NSString *)numericalConversion:(NSInteger)num
{
    if (num>10000) {
        return [NSString stringWithFormat:@"%0.1f",((float)num)/10000];
    }
    return [NSString stringWithFormat:@"%li",num];
}
///密码限制：字母、数字、特殊字母（除空格），两种以上类型组成
- (BOOL)checkPasswordLimit
{
    NSString *stringResult1 = [NSString publicStringWithString1:self string2:Special_Character];
    NSString *stringResult2 = [NSString publicStringWithString1:self string2:NUMBERS];
    NSString *stringResult3 = [NSString publicStringWithString1:self string2:kAlpha];
    
    BOOL stringResultFlag1 = ![NSString isNull:stringResult1];
    BOOL stringResultFlag2 = ![NSString isNull:stringResult2];
    BOOL stringResultFlag3 = ![NSString isNull:stringResult3];
    
    if ((stringResultFlag1 && stringResultFlag2) || (stringResultFlag1 && stringResultFlag3) || (stringResultFlag3 && stringResultFlag2))
    {
        NSRange _range = [self rangeOfString:@" "];
        if (_range.location != NSNotFound) {
            //有空格
            [iToast alertWithTitle:kLocalizedString(@"密码不可有空格，请从新输入")];
            
            return NO;
        }else {
            //没有空格
            //            [iToast alertWithTitle:@"限制成功"];
            return YES;
        }
    }
    else
    {
        //        [iToast alertWithTitle:@"限制失败"];
        return NO;
    }
    
}

+ (NSString *)publicStringWithString1:(NSString *)string1 string2:(NSString *)string2 {
    NSString *publicString = @"";
    for (NSInteger i = 0; i < string1.length ; i++) {
        unichar char1 = [string1 characterAtIndex:i];
        for (NSInteger j = 0; j < string2.length; j++) {
            unichar char2 = [string2 characterAtIndex:j];
            if (char1 == char2) {
                publicString = [NSString stringWithFormat:@"%@%c",publicString,char1];
                break;
            }
        }
    }
    return publicString;
}

@end
