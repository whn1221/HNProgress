//
//  UIView+HNCircleProgress.m
//  HNUploadProgress
//
//  Created by xydtech on 16/4/6.
//  Copyright © 2016年 wanghn. All rights reserved.
//

#import "UIView+HNCircleProgress.h"

#define kHNCircleProgressTag 123456

@implementation UIView (HNCircleProgress)

- (void)addProgressView {
    
    HNCircleProgress *progressView = (HNCircleProgress *)[self viewWithTag:kHNCircleProgressTag];
    if (progressView && [progressView isKindOfClass:[HNCircleProgress class]]) {
        progressView.progress = 0;
    } else {
        HNCircleProgress *progressView = [[HNCircleProgress alloc] initWithFrame:self.bounds];
        progressView.tag = kHNCircleProgressTag;
        progressView.targetView = self;
        progressView.insideCircleColor = [UIColor colorWithWhite:1 alpha:0.8];
        progressView.outerRingColor = [UIColor colorWithWhite:1 alpha:0.8];
        progressView.type = HNCircleProgressTypeMinus;
        [self addSubview:progressView];
    }
    progressView.alpha = 0;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        progressView.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setProgress:(CGFloat)progress {
    HNCircleProgress *progressView = (HNCircleProgress *)[self viewWithTag:kHNCircleProgressTag];
    if (progressView && [progressView isKindOfClass:[HNCircleProgress class]]) {
        progressView.progress = progress;
    }
}

- (CGFloat)progress {
    HNCircleProgress *progressView = (HNCircleProgress *)[self viewWithTag:kHNCircleProgressTag];
    if (progressView && [progressView isKindOfClass:[HNCircleProgress class]]) {
        return progressView.progress;
    }
    return 0;
}

- (void)setOuterRingColor:(UIColor *)outerRingColor
{
    HNCircleProgress *progressView = (HNCircleProgress *)[self viewWithTag:kHNCircleProgressTag];
    if (progressView && [progressView isKindOfClass:[HNCircleProgress class]]) {
        progressView.outerRingColor = outerRingColor;
    }
}

- (void)setInsideCircleColor:(UIColor *)insideCircleColor
{
    HNCircleProgress *progressView = (HNCircleProgress *)[self viewWithTag:kHNCircleProgressTag];
    if (progressView && [progressView isKindOfClass:[HNCircleProgress class]]) {
        progressView.insideCircleColor = insideCircleColor;
    }
}

- (UIColor *)outerRingColor
{
    HNCircleProgress *progressView = (HNCircleProgress *)[self viewWithTag:kHNCircleProgressTag];
    if (progressView && [progressView isKindOfClass:[HNCircleProgress class]]) {
        return progressView.outerRingColor;
    }
    return nil;
}

- (UIColor *)insideCircleColor
{
    HNCircleProgress *progressView = (HNCircleProgress *)[self viewWithTag:kHNCircleProgressTag];
    if (progressView && [progressView isKindOfClass:[HNCircleProgress class]]) {
        return progressView.insideCircleColor;
    }
    return nil;
}

- (void)setType:(HNCircleProgressType)type
{
    HNCircleProgress *progressView = (HNCircleProgress *)[self viewWithTag:kHNCircleProgressTag];
    if (progressView && [progressView isKindOfClass:[HNCircleProgress class]]) {
        progressView.type = type;
    }
}

- (HNCircleProgressType)type
{
    HNCircleProgress *progressView = (HNCircleProgress *)[self viewWithTag:kHNCircleProgressTag];
    if (progressView && [progressView isKindOfClass:[HNCircleProgress class]]) {
        return progressView.type;
    }
    return 0;
}

- (void)removeProgressViewAnimated:(BOOL)animated {
    HNCircleProgress *progressView = (HNCircleProgress *)[self viewWithTag:kHNCircleProgressTag];
    if (progressView && [progressView isKindOfClass:[HNCircleProgress class]]) {
        if (animated) {
            [UIView animateWithDuration:0.25 animations:^{
                progressView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            } completion:^(BOOL finished) {
                if (finished) {
                    [progressView removeFromSuperview];
                }
            }];
        } else {
            [progressView removeFromSuperview];
        }
    }
}

@end
