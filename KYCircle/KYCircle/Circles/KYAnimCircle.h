//
//  KYAnimCircle.h
//  KYCircle
//
//  Created by kingly on 2017/5/12.
//  Copyright © 2017年 KYCircle Software (https://github.com/kingly09/KYCircle) by kingly inc.  

//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KY_RGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define KY_RGBA16(rgbaValue) [UIColor colorWithRed:((float)((rgbaValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbaValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbaValue & 0xFF))/255.0 alpha:((float)((rgbaValue & 0xFF000000) >> 24))/255.0]

typedef void(^KYAnimCompleteBlock)(int caromNum);

@interface KYAnimCircle : UIView

@property (strong,nonatomic) UIColor *backgroundColor;  //动画背景颜色

@property (strong,nonatomic) UIColor *strokeColor;      //圆环的颜色

@property (strong,nonatomic) UIColor *fillColor;        //背景填充色

@property (assign,nonatomic) CGFloat lineWidth;         //线的宽度

@property (assign,nonatomic) BOOL clockWise;    // YES 为按照顺时针方向,  NO,按照逆时针方向

/**
 初始化环形视图

 @param frame 视图frame
 @param lineWidth 环的宽度
 @return 返回环形视图

 */
-(instancetype)initWithFrame:(CGRect)frame lineWidth:(float)lineWidth;

/**
 设置动画的时间，以及动画结束后的回调

 @param duration 动画执行时间
 @param block 动画执行完成后的回调
 */
-(void)animateWithDuration:(NSTimeInterval)duration completeBlock:(KYAnimCompleteBlock )block;



@end
