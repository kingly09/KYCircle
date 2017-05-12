//
//  KYCircleProgress.h
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
 绘制一个带有进度条的环形
 */
@interface KYCircleProgress : UIView

@property (assign,nonatomic) float progress;  //百分比

@property (assign,nonatomic) CGFloat lineWidth; //环的宽度

/**
 带有进度条的环形

 @param frame 视图frame
 @param lineWidth 环的宽度
 @return 返回环形视图

 */
-(instancetype)initWithFrame:(CGRect)frame lineWidth:(float)lineWidth;

@end
