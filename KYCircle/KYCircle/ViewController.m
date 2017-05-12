//
//  ViewController.m
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

#import "ViewController.h"
#import "KYHollowCircle.h"
#import "KYCircleProgress.h"
#import "KYAnimCircle.h"

@interface ViewController ()

@property (strong, nonatomic) KYHollowCircle *hollowCircle;     //创建一个环形圆
@property (strong, nonatomic) KYCircleProgress *circleProgress; //进度条环形圆
@property (strong, nonatomic) UILabel *percentLabel;            //百分比
@property (strong, nonatomic) UIView *progressView;             //进度条视图
@property (strong, nonatomic) UIButton *animViewBtn;            //动画视图



@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  //绘制一个环形
  _hollowCircle = [[KYHollowCircle alloc] initWithFrame:CGRectMake(40, 40, 100, 100)];
  [self.view addSubview:_hollowCircle];
  
  //绘制一个进度条环形视图
  [self showProgressView];
  
  //动画视图
  _animViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   _animViewBtn.frame = CGRectMake(40,220, 150, 150);
  [_animViewBtn adjustsImageWhenHighlighted];
  [_animViewBtn adjustsImageWhenDisabled];
  _animViewBtn.backgroundColor = [UIColor grayColor];
  _animViewBtn.imageView.contentMode = UIViewContentModeCenter;
  [_animViewBtn addTarget:self action:@selector(onClickAnimViewBtn:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_animViewBtn];
}

-(void)showProgressView {
  
  //进度条视图 
  _progressView = [[UIView alloc] init];
  _progressView.backgroundColor = [UIColor blackColor];
  _progressView.frame = CGRectMake(160, 40, 150, 150);
  [self.view addSubview:_progressView];
  
  
  CGFloat margin = 15.0f;
  CGFloat circleWidth = _progressView.bounds.size.width - 2*margin;
  CGRect  frame =   CGRectMake(15, 15, circleWidth, circleWidth);
  //百分号Label
  _percentLabel  = [[UILabel alloc] initWithFrame:frame];
  _percentLabel.textColor = [UIColor whiteColor];
  _percentLabel.textAlignment = NSTextAlignmentCenter;
  _percentLabel.font = [UIFont boldSystemFontOfSize:20];
  _percentLabel.text = @"0%";
  [_progressView addSubview:_percentLabel];
  
  //进度条环形圆
  float lineWidth = 0.1*circleWidth;
  _circleProgress = [[KYCircleProgress alloc] initWithFrame:frame lineWidth:lineWidth];
  [_progressView addSubview:_circleProgress];
  
  UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(40, _hollowCircle.frame.origin.y + _hollowCircle.frame.size.height + 15, _hollowCircle.frame.size.width, 30)];
  [slider addTarget:self action:@selector(sliderMethod:) forControlEvents:UIControlEventValueChanged];
  [slider setMaximumValue:1];
  [slider setMinimumValue:0];
  [slider setMinimumTrackTintColor:[UIColor colorWithRed:255.0f/255.0f green:151.0f/255.0f blue:0/255.0f alpha:1]];
  [self.view addSubview:slider];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)sliderMethod:(UISlider*)slider
{
  _circleProgress.progress = slider.value;
  _percentLabel.text = [NSString stringWithFormat:@"%.0f%%",slider.value*100];
}

#pragma mark - 点击动画视图

-(void)onClickAnimViewBtn:(UIButton *)sender{
   
   KYAnimCircle *animCircle = [[KYAnimCircle alloc] initWithFrame:sender.bounds];
   animCircle.backgroundColor = [UIColor whiteColor];
//   [animCircle animateWithDuration:3.0 completeBlock:^(int caromNum) {
//     [animCircle removeFromSuperview];
//     NSLog(@"连击了：%d",caromNum);  
//   }];
  
  [animCircle animateWithDuration:3.0 completeBlock:^(int caromNum) {
      [animCircle removeFromSuperview];
      NSLog(@"连击了：%d",caromNum);  
  } withPerClickBlock:^(int caromNum) {
     
      NSLog(@"第%d次连击了",caromNum);  
     
  }];

   [sender addSubview:animCircle];
}

@end
