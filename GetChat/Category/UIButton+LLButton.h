//
//  UIButton+LLButton.h
//  test_login
//
//  Created by liguangluo on 16/1/5.
//  Copyright © 2016年 liguangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LLButton)

+(void)createSimpleButtonFrame:(CGRect)rect color:(UIColor *)color target:(id)target selector:(SEL)selector;
+(UIButton *)createSimpleButtonTitle:(NSString *) titile Frame:(CGRect)rect color:(UIColor *)color target:(id)target selector:(SEL)selector;

@end
