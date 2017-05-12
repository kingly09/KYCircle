//
//  KYAnimCircle.m
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

#import "KYAnimCircle.h"
#import "KYHollowCircle.h"

@interface KYAnimCircle ()
{
    UIView *animCircleBg;  //圆的背景
    UILabel *numerLabel;   //点击的次数
    UILabel *noteLabel;    //连发
    
    KYHollowCircle  *backCircle;     //背景
    KYHollowCircle  *circleProgress; //创建进度
    
    KYAnimPerClickBlock _animPerClickBlock; //每次点击的回调 
    
}

@property (strong, nonatomic) UIButton *caromBtn; //连击按钮
@end

@implementation KYAnimCircle

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
      [self setupAnimCircleWithlineWidth:0.1*self.bounds.size.width];
      [self customView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame lineWidth:(float)lineWidth{
  self = [super initWithFrame:frame];
  if (self) {
    [self customView];
    [self setupAnimCircleWithlineWidth:lineWidth];
   
  }
  return self;
}
/**
 初始化一个环形的属性
 
 @param lineWidth 环的宽度
 */
-(void)setupAnimCircleWithlineWidth:(float)lineWidth{
  
  _lineWidth = lineWidth;
  _backgroundColor = [UIColor blackColor];
  _strokeColor = KY_RGB16(0xea3267);
  _fillColor   = [UIColor whiteColor];
  
  //按照顺序创建贝塞尔路径
  _clockWise = YES;
}

-(void)customView{
  
  animCircleBg = [[UIView alloc] initWithFrame:self.bounds];
  animCircleBg.backgroundColor = _backgroundColor;
  [self addSubview:animCircleBg];
  
  
  CGRect frame = CGRectMake(0, 0, self.bounds.size.width*0.8, self.bounds.size.width*0.8);

  //背景圆
  backCircle = [[KYHollowCircle alloc] initWithFrame:frame lineWidth:_lineWidth];
  backCircle.center = self.center;
  backCircle.fillColor   = _fillColor;
  backCircle.strokeColor = _strokeColor;
  backCircle.strokeEnd   = 1;
  backCircle.lineWidth = 0.1*self.bounds.size.width - 2;
  [self addSubview:backCircle];
  
  
  //创建进度
  circleProgress = [[KYHollowCircle alloc] initWithFrame:frame lineWidth:_lineWidth];
  circleProgress.center = self.center;
  circleProgress.fillColor =  [UIColor whiteColor];
  //指定path的渲染颜色
  circleProgress.strokeColor  = _backgroundColor;
  circleProgress.strokeEnd   = 1;
  [self addSubview:circleProgress];
  
  //点击的次数
  numerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.bounds.size.height - 40)/2, self.bounds.size.width, 20)];
  numerLabel.textColor = _strokeColor;
  numerLabel.textAlignment = NSTextAlignmentCenter;
  numerLabel.font = [UIFont boldSystemFontOfSize:24];
  numerLabel.text = @"1";
  [self addSubview:numerLabel];
  
  //连发
  noteLabel = [[UILabel alloc] init];
  noteLabel.font = [UIFont systemFontOfSize:13];
  noteLabel.textColor = _strokeColor;
  noteLabel.textAlignment = NSTextAlignmentCenter;
  noteLabel.frame = CGRectMake(0, numerLabel.frame.origin.y + numerLabel.frame.size.height, numerLabel.frame.size.width, 20);
  noteLabel.text = @"连发";
  [self addSubview:noteLabel];  
  
  //连击
  _caromBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
   _caromBtn.frame = CGRectMake(0,0, self.frame.size.width, self.frame.size.height);
  [_caromBtn adjustsImageWhenHighlighted];
  [_caromBtn adjustsImageWhenDisabled];
  _caromBtn.backgroundColor = [UIColor clearColor];
  _caromBtn.imageView.contentMode = UIViewContentModeCenter;
  [_caromBtn addTarget:self action:@selector(onClickCaromBtnView:) forControlEvents:UIControlEventTouchUpInside];
   [self addSubview:_caromBtn]; 
 
}

-(void)animateWithDuration:(NSTimeInterval)duration completeBlock:(KYAnimCompleteBlock )block{
   
 
  [self addAnimation:duration];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block([numerLabel.text intValue]);
       [self removeFromSuperview];
  });
 
}

-(void)animateWithDuration:(NSTimeInterval)duration completeBlock:(KYAnimCompleteBlock )block withPerClickBlock:(KYAnimPerClickBlock )animPerClickBlock{
   
    _animPerClickBlock = animPerClickBlock;
    
    _animPerClickBlock([numerLabel.text intValue]);
    
    [self addAnimation:duration];
  
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block([numerLabel.text intValue]);
       [self removeFromSuperview];
   });
}


/**
 添加进度条动画
 */
-(void)addAnimation:(NSTimeInterval)duration{
  
  CABasicAnimation *strokeEndAnimate = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  strokeEndAnimate.fromValue = [NSNumber numberWithFloat:0.0];
  strokeEndAnimate.toValue = [NSNumber numberWithFloat:1];
  
  CAAnimationGroup *strokeAnimateGroup = [CAAnimationGroup animation];
  strokeAnimateGroup.duration = duration;
  strokeAnimateGroup.repeatCount = 1;
  strokeAnimateGroup.animations = @[strokeEndAnimate];
  
  [[circleProgress  circleLayer] addAnimation:strokeAnimateGroup forKey:nil];
  
}

-(void)onClickCaromBtnView:(UIButton *)sender{
  
   numerLabel.text = [NSString stringWithFormat:@"%d",[numerLabel.text intValue] +1];
   
   _animPerClickBlock([numerLabel.text intValue]);
}

#pragma mark - 对外的方法
-(void)setLineWidth:(CGFloat)lineWidth{
  
  _lineWidth = lineWidth;
  backCircle.lineWidth = _lineWidth;
  circleProgress.lineWidth = _lineWidth;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor{
  
  _backgroundColor = backgroundColor;
  animCircleBg.backgroundColor = _backgroundColor;
  circleProgress.strokeColor  = _backgroundColor;
}





@end
