//
//  KYCircleProgress.m
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

#import "KYCircleProgress.h"
#import "KYHollowCircle.h"

#define KY_RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]


static CGFloat endPointMargin = 1.0f;

@interface KYCircleProgress ()
{
    KYHollowCircle  *backCircle; //背景
    KYHollowCircle  *circleProgress; //创建进度
    
    UIView *endPointDot; //在终点位置添加一个点 
}
@end

@implementation KYCircleProgress

-(instancetype)initWithFrame:(CGRect)frame lineWidth:(float)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineWidth = lineWidth;
        [self customView];
    }
    return self;
}
/**
 自定义
 */
-(void)customView{
   
    //背景圆
    backCircle = [[KYHollowCircle alloc] initWithFrame:self.bounds lineWidth:_lineWidth];
    backCircle.fillColor   = [UIColor clearColor];
    backCircle.strokeColor = KY_RGB(50,50,50);
    backCircle.strokeEnd   = 1;
    [self addSubview:backCircle];
    
     //创建进度
    circleProgress = [[KYHollowCircle alloc] initWithFrame:self.bounds lineWidth:_lineWidth];
    circleProgress.fillColor =  [UIColor clearColor];
    //指定path的渲染颜色
    circleProgress.strokeColor  = [UIColor blackColor];
    circleProgress.lineCap = kCALineCapRound;
    circleProgress.strokeEnd = 0;

     //设置渐变颜色
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[KY_RGB(255, 151, 0) CGColor],(id)[KY_RGB(255, 203, 0) CGColor], nil]];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    [gradientLayer setMask:[circleProgress circleLayer]]; //用progressLayer来截取渐变层
    [self.layer addSublayer:gradientLayer];
    
    //添加结束位置的小点
    [self addEndPointDot];
}

/**
 添加结束位置的小点
 */
-(void)addEndPointDot{
  
   //用于显示结束位置的小点
    endPointDot = [[UIImageView alloc] init];
    endPointDot.frame = CGRectMake(0, 0, _lineWidth - endPointMargin*2,_lineWidth - endPointMargin*2);
    endPointDot.hidden = true;
    endPointDot.backgroundColor = [UIColor redColor];
    endPointDot.layer.masksToBounds = true;
    endPointDot.layer.cornerRadius = endPointDot.bounds.size.width/2;
    [self addSubview:endPointDot];

}

//更新小点的位置
-(void)updateEndPoint
{
    //转成弧度
    CGFloat angle = M_PI*2*_progress;
    float radius = (self.bounds.size.width-_lineWidth)/2.0;
    int index = (angle)/M_PI_2;//用户区分在第几象限内
    float needAngle = angle - index*M_PI_2;//用于计算正弦/余弦的角度
    float x = 0,y = 0;//用于保存_dotView的frame
    switch (index) {
        case 0:
            NSLog(@"第一象限");
            x = radius + sinf(needAngle)*radius;
            y = radius - cosf(needAngle)*radius;
            break;
        case 1:
            NSLog(@"第二象限");
            x = radius + cosf(needAngle)*radius;
            y = radius + sinf(needAngle)*radius;
            break;
        case 2:
            NSLog(@"第三象限");
            x = radius - sinf(needAngle)*radius;
            y = radius + cosf(needAngle)*radius;
            break;
        case 3:
            NSLog(@"第四象限");
            x = radius - cosf(needAngle)*radius;
            y = radius - sinf(needAngle)*radius;
            break;
            
        default:
            break;
    }
    
    //更新圆环的frame
    CGRect rect = endPointDot.frame;
    rect.origin.x = x + endPointMargin;
    rect.origin.y = y + endPointMargin;
    endPointDot.frame = rect;
    //移动到最前
    [self bringSubviewToFront:endPointDot];
    endPointDot.hidden = false;
    if (_progress == 0 || _progress == 1) {
        endPointDot.hidden = true;
    }
}

/**
  设置进度条
 */
-(void)setProgress:(float)progress
{
    _progress = progress;
    circleProgress.strokeEnd = progress;
    [self updateEndPoint];
    [circleProgress removeAllAnimations];
}

@end
