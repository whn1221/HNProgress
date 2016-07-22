//
//  HNCircleProgress.m
//  HNUploadProgress
//
//  Created by xydtech on 16/4/5.
//  Copyright © 2016年 wanghn. All rights reserved.
//

#import "HNCircleProgress.h"

#define kHNCircleProgressCircleRate 0.35
#define kHNCircleProgressLineWidthRate 0.05
@interface HNCircleProgress()

@property(nonatomic,strong)CAShapeLayer * progressLayer;


@end

@implementation HNCircleProgress

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    if (_progress != progress) {
        _progress = progress;
    }
    
    if (progress < 0 || progress > 1) {
        return;
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (self.type == HNCircleProgressTypeAdd) {
        [self drawFramePie:rect];
        [self drawFillPie:rect color:self.insideCircleColor percentage:self.progress];
    }else if (self.type == HNCircleProgressTypeMinus){
        [self drawFillPie:rect color:self.insideCircleColor percentage:self.progress];
    }
}

- (void)drawFillPie:(CGRect)rect color:(UIColor *)color percentage:(CGFloat)percentage {
    if (nil == _progressLayer) {
        CGFloat trueRadius = rect.size.width * kHNCircleProgressCircleRate;
        CGFloat space = rect.size.width * kHNCircleProgressLineWidthRate;
        CGFloat progressRadius = (trueRadius - space) / 2;
        CAShapeLayer *progressLayer = [CAShapeLayer layer];
        progressLayer.frame = self.bounds;
        progressLayer.strokeColor = color.CGColor;
        progressLayer.fillColor = [UIColor clearColor].CGColor;
        progressLayer.lineWidth = progressRadius * 2;
        UIBezierPath *proBezierPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:progressRadius startAngle:-M_PI_2 endAngle:-M_PI_2 + 2 * M_PI clockwise:YES];
        progressLayer.path = proBezierPath.CGPath;
        CATransform3D rotationTransform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
        progressLayer.transform = rotationTransform;
        progressLayer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.layer addSublayer:progressLayer];
        self.progressLayer = progressLayer;
    }
    if (self.type == HNCircleProgressTypeAdd) {
        self.progressLayer.strokeStart = 1 - self.progress;
    }else if (self.type == HNCircleProgressTypeMinus){
        self.progressLayer.strokeEnd = 1 - self.progress;
    }
}

- (void)drawFramePie:(CGRect)rect {
    CGFloat radius = CGRectGetWidth(rect) * (kHNCircleProgressCircleRate - kHNCircleProgressLineWidthRate);
    CGFloat centerX = CGRectGetWidth(rect) * 0.5;
    CGFloat centerY = CGRectGetHeight(rect) * 0.5;
    
    [self.outerRingColor set];
    CGRect frameRect = CGRectMake(
                                  centerX - radius,
                                  centerY - radius,
                                  radius * 2,
                                  radius* 2);
    UIBezierPath *insideFrame = [UIBezierPath bezierPathWithOvalInRect:frameRect];
    insideFrame.lineWidth = 1;
    [insideFrame stroke];
}



@end
