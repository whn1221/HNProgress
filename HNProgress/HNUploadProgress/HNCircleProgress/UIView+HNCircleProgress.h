//
//  UIView+HNCircleProgress.h
//  HNUploadProgress
//
//  Created by xydtech on 16/4/6.
//  Copyright © 2016年 wanghn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNCircleProgress.h"

@interface UIView (HNCircleProgress)
/*
 在视图中添加进度视图
 */
- (void)addProgressView;

/*
 进度视图的进度，0到1
 */
@property(nonatomic) CGFloat progress;

/**
 *  外部圆环颜色以及透明度,默认白色,透明度0.8
 */
@property(nonatomic,strong)UIColor * outerRingColor;
/**
 *  内部填充颜色以及透明度,默认白色,透明度0.8
 */
@property(nonatomic,strong)UIColor * insideCircleColor;
/**
 *  类型,默认减少的状态
 */
@property(nonatomic,assign)HNCircleProgressType type;

/*
 移除进度视图
 移除时是否需要动画
 */
- (void)removeProgressViewAnimated:(BOOL)animated;

@end
