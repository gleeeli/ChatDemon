//
//  UIButton+LLButton.m
//  test_login
//
//  Created by liguangluo on 16/1/5.
//  Copyright © 2016年 liguangluo. All rights reserved.
//

#import "UIButton+LLButton.h"

@implementation UIButton (LLButton)

+(void)createSimpleButtonFrame:(CGRect)rect color:(UIColor *)color target:(id)target selector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    btn.backgroundColor = color;
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [((UIViewController *)target).view addSubview:btn];
    
}

+(UIButton *)createSimpleButtonTitle:(NSString *) titile Frame:(CGRect)rect color:(UIColor *)color target:(id)target selector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    btn.backgroundColor = color;
    [btn setTitle:titile forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [((UIViewController *)target).view addSubview:btn];
    
    return btn;
}

@end
