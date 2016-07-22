//
//  HNRingProgerss.h
//  HNUploadProgress
//
//  Created by xydtech on 16/4/5.
//  Copyright © 2016年 xydtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNRingProgerss : UIView

- (void)drawProgerss:(CGFloat)progress;

/**
 *  左半边圆环渐变色,数组元素类型必须的CGColor类型
 */
@property(nonatomic,strong)NSArray<__kindof UIColor *> * leftRingColor;
/**
 *  右半边圆环渐变色,数组元素类型必须的CGColor类型
 */
@property(nonatomic,strong)NSArray<__kindof UIColor *> * rightRingColor;

@end
