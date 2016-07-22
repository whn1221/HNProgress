//
//  HNCircleProgress.h
//  HNUploadProgress
//
//  Created by xydtech on 16/4/5.
//  Copyright © 2016年 wanghn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum HNCircleProgressType{
    HNCircleProgressTypeAdd,
    HNCircleProgressTypeMinus
}HNCircleProgressType;

@interface HNCircleProgress : UIView

@property(nonatomic,weak)UIView * targetView;

@property(nonatomic,assign)CGFloat progress;

@property(nonatomic,strong)UIColor * outerRingColor;

@property(nonatomic,strong)UIColor * insideCircleColor;
/**
 *  类型
 */
@property(nonatomic,assign)HNCircleProgressType type;

@end
