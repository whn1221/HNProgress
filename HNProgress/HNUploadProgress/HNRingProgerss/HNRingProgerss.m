//
//  HNRingProgerss.m
//  HNUploadProgress
//
//  Created by xydtech on 16/4/5.
//  Copyright © 2016年 xydtech. All rights reserved.
//

#import "HNRingProgerss.h"

@interface HNRingProgerss()

@property(nonatomic,assign)CGFloat progress;

@property(nonatomic,strong)CAShapeLayer * progressLayer;

@property(nonatomic,strong)UILabel * progressLab;

@end

@implementation HNRingProgerss

- (UILabel *)progressLab
{
    if (nil == _progressLab) {
        _progressLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _progressLab.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        _progressLab.textAlignment = NSTextAlignmentCenter;
        _progressLab.font = [UIFont systemFontOfSize:12];
        _progressLab.textColor = [UIColor redColor];
        [self addSubview:_progressLab];
    }
    return _progressLab;
}


- (void)drawProgerss:(CGFloat)progress
{
    self.progress = progress;
    self.progressLayer.opacity = 0;//每次重画时候把上次的隐藏
    self.progressLab.text = [NSString stringWithFormat:@"%.1f%%", progress * 100];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self drawProgerssLayer];
}

- (void)drawProgerssLayer
{
    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    CGFloat radius = self.frame.size.width/2 - 20;
    NSLog(@"%f", self.frame.size.width);
//    CGFloat radius = 80;
    CGFloat startAngle = - M_PI_2;  //设置进度条起点位置
    CGFloat endAngle = -M_PI_2 + M_PI * 2 * self.progress;  //设置进度条终点位置
    
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.lineWidth = 10;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.opacity = 1;
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.strokeColor = [UIColor redColor].CGColor;//这里必须设置否则下面渲染的时候见找不到路径,则会显示不出来
    UIBezierPath * bPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    self.progressLayer.path = bPath.CGPath;
    [self.layer addSublayer:self.progressLayer];
    
    CALayer *gradientLayer = [CALayer layer];
    //左侧渐变色
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    
    leftLayer.frame = CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.height);
    leftLayer.locations = @[@0.3, @0.9, @1];
    if (self.leftRingColor.count > 0) {
        NSMutableArray * colArr = [NSMutableArray array];
        for (UIColor *col in self.leftRingColor) {
            [colArr addObject:(id)col.CGColor];
        }
        leftLayer.colors = colArr;
    }else{
        leftLayer.colors = @[(id)[UIColor yellowColor].CGColor, (id)[UIColor greenColor].CGColor];
    }
    [gradientLayer addSublayer:leftLayer];
    
    //右侧渐变色
    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    rightLayer.frame = CGRectMake(self.bounds.size.width / 2, 0, self.bounds.size.width / 2, self.bounds.size.height);
    rightLayer.locations = @[@0.3, @0.9, @1];
    if (self.rightRingColor.count > 0) {
        NSMutableArray * colArr = [NSMutableArray array];
        for (UIColor *col in self.rightRingColor) {
            [colArr addObject:(id)col.CGColor];
        }
        rightLayer.colors = colArr;
    }else{
        rightLayer.colors = @[(id)[UIColor yellowColor].CGColor, (id)[UIColor redColor].CGColor];
    }
    [gradientLayer addSublayer:rightLayer];
    
    [gradientLayer setMask:self.progressLayer];
    [self.layer addSublayer:gradientLayer];
    
}

@end
