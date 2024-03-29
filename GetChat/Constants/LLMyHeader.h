//
//  LLMyHeader.h
//  test_login
//
//  Created by huangxianchao on 2/15/16.
//  Copyright © 2016 liguangluo. All rights reserved.
//

#ifndef LLMyHeader_h
#define LLMyHeader_h

#define LL_ORINGX(X) X.frame.origin.x
#define LL_ORINGY(Y) Y.frame.origin.y
#define LL_mmWidth(x) x.frame.size.width
#define LL_mmHeight(y) y.frame.size.height
#define LL_AUTO_ORINGX(w) (w.frame.origin.x+w.frame.size.width)
#define LL_AUTO_ORINGY(h) (h.frame.origin.y + h.frame.size.height)

/*---------------------------  适配屏幕☟  ---------------------------*/
#define ORIGINAL_WIDTH 320.0      //当前原型图基准iOS设备的逻辑分辨率的宽
#define ORIGINAL_HEIGHT 568.0     //当前原型图基准iOS设备的逻辑分辨率的高

///水平方向适配系数
#define FIT_WIDTH (([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)/ORIGINAL_WIDTH)
///竖直方向适配系数
#define FIT_HEIGHT (([UIScreen mainScreen].bounds.size.height > [UIScreen mainScreen].bounds.size.width ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)/ORIGINAL_HEIGHT)

///非图标控件frame的适配
#define FitCGRectMake(X,Y,W,H) CGRectMake((X)*FIT_WIDTH,(Y)*FIT_HEIGHT,(W)*FIT_WIDTH,(H)*FIT_HEIGHT)

///图标控件frame的适配
#define PitCGRectMake(X,Y,W,H) CGRectMake((X)*FIT_WIDTH,(Y)*FIT_HEIGHT,(W)*FIT_WIDTH,(H)*FIT_WIDTH)

///图标控件frame的适配(仅宽度)
#define IitCGRectMake(X,Y,W,H) CGRectMake((X)*FIT_WIDTH,(Y)*FIT_WIDTH,(W)*FIT_WIDTH,(H)*FIT_WIDTH)

///字体的适配
#define FitFontSize(S) [UIFont systemFontOfSize:(S)*FIT_WIDTH]

///Point的适配
#define FitCGPointMake(X,Y) CGPointMake((X)*FIT_WIDTH,(Y)*FIT_HEIGHT)

///Size的适配
#define FitCGSizeMake(W,H) CGSizeMake((W)*FIT_WIDTH,(H)*FIT_HEIGHT)

#endif /* LLMyHeader_h */
