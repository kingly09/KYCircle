//
//  KYHollowCircle.m
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

#import "KYHollowCircle.h"

@interface KYHollowCircle ()
{
    CAShapeLayer  * _hollowCircleLayer; //环形
    UIBezierPath  *_bezierPath; //贝塞尔路径
    float centerX;
    float centerY;
    float radius;  //圆的半径
}
@end

@implementation KYHollowCircle

-(instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    [self setupShapeLayerWithlineWidth:10];
    [self customView];
  }
  return self;
}

-(instancetype)initWithFrame:(CGRect)frame  lineWidth:(float)lineWidth
{
  self = [super initWithFrame:frame];
  if (self) {
  
   [self setupShapeLayerWithlineWidth:lineWidth];
   [self customView];
  
  }
  return self;
}

/**
 初始化一个环形的属性
 
 @param lineWidth 环的宽度
 */
-(void)setupShapeLayerWithlineWidth:(float)lineWidth{
  
  _lineWidth = lineWidth;

  _strokeColor = [UIColor redColor];
  _fillColor   = [UIColor clearColor];
  _strokeEnd   = 1;
  
  centerX = self.bounds.size.width/2.0;
  centerY = self.bounds.size.height/2.0;
  
  //半径
  radius = (self.bounds.size.width-_lineWidth)/2.0;
  
  //按照顺序创建贝塞尔路径
  _clockWise = YES;
}

/**
 自定义
 */
-(void)customView{
  
  //初始化一个路径,创建贝塞尔路径
  _bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:(-0.5f*M_PI) endAngle:1.5f*M_PI clockwise:_clockWise];
  
  //绘制一个空心环形
  _hollowCircleLayer = [CAShapeLayer layer];
  _hollowCircleLayer.frame     = self.bounds;
  _hollowCircleLayer.fillColor =  [_fillColor CGColor];
  _hollowCircleLayer.strokeColor  = _strokeColor.CGColor;
  _hollowCircleLayer.lineWidth = _lineWidth;
  _hollowCircleLayer.path = [_bezierPath CGPath];
  _hollowCircleLayer.strokeStart = _strokeStart;
  _hollowCircleLayer.strokeEnd   = _strokeEnd;
  self.layer.masksToBounds = YES;
  [self.layer addSublayer:_hollowCircleLayer];  
  
}

-(void)setLineWidth:(CGFloat)lineWidth{
  
  _lineWidth = lineWidth;
  _hollowCircleLayer.lineWidth = _lineWidth;
}

-(void)setClockWise:(BOOL)clockWise{
  //初始化一个路径,创建贝塞尔路径
  _clockWise = clockWise;
  _bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:(-0.5f*M_PI) endAngle:1.5f*M_PI clockwise:_clockWise];
  _hollowCircleLayer.path = [_bezierPath CGPath];
}

-(void)setFillColor:(UIColor *)fillColor{
  
  _fillColor = fillColor;
  _hollowCircleLayer.fillColor =  [fillColor CGColor];
}

-(void)setStrokeColor:(UIColor *)strokeColor{
  
  _strokeColor  = strokeColor;
  _hollowCircleLayer.strokeColor  = _strokeColor.CGColor;
}

-(void)setLineCap:(NSString *)lineCap{
   
  _lineCap = lineCap;
  if (_lineCap.length == 0) {
    _lineCap = kCGLineCapButt;
  }
  _hollowCircleLayer.lineCap = _lineCap;
  
}

-(void)setStrokeStart:(CGFloat)strokeStart{
   
   _strokeStart = strokeStart;
   _hollowCircleLayer.strokeStart = _strokeStart;
}

-(void)setStrokeEnd:(CGFloat)strokeEnd{
   _strokeEnd = strokeEnd;
   _hollowCircleLayer.strokeEnd   = _strokeEnd;
}

-(void)removeAllAnimations{

  [_hollowCircleLayer removeAllAnimations];
}

-(CALayer *)circleLayer{

   return _hollowCircleLayer;
}

@end
