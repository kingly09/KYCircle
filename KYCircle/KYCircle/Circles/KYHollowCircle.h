//
//  KYHollowCircle.h
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

/**
 绘制环形圆
 */
@interface KYHollowCircle : UIView

@property (assign,nonatomic) CGFloat lineWidth; //环的宽度

@property (assign,nonatomic) BOOL clockWise;    // YES 为按照顺时针方向,  NO,按照逆时针方向

@property (strong,nonatomic) UIColor *strokeColor; //圆环的颜色

@property (strong,nonatomic) UIColor *fillColor;   //背景填充色

@property (assign,nonatomic) CGFloat strokeStart;  //开始环形点 (0 ~~ 1)
@property (assign,nonatomic) CGFloat strokeEnd;    //环形结束点 (0 ~~ 1)

//起点的圆点的形状 （kCGLineCapButt 该属性值指定不绘制端点， 线条结尾处直接结束。这是默认值。）
//kCGLineCapRound 该属性值指定绘制圆形端点， 线条结尾处绘制一个直径为线条宽度的半圆
//kCGLineCapSquare 该属性值指定绘制方形端点。 线条结尾处绘制半个边长为线条宽度的正方形。需要说明的是，这种形状的端点与“butt”形状的端点十分相似，只是采用这种形式的端点的线条略长一点而已
@property(nonatomic,copy) NSString *lineCap; 
/**
 初始化环形视图

 @param frame 视图frame
 @param lineWidth 环的宽度
 @return 返回环形视图

 */
-(instancetype)initWithFrame:(CGRect)frame lineWidth:(float)lineWidth;

/**
 移除所有动画
 */
-(void)removeAllAnimations;

/**
 获得圆的layer

 @return 获得圆的layer
 */
-(CALayer *)circleLayer;

@end
