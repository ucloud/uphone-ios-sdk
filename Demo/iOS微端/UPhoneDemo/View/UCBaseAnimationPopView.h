//
//  UCBaseAnimationPopView.h
//  CQLives
//
//  Created by user on 2020/4/28.
//  Copyright © 2020 鹿达令. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 显示时动画弹框样式
 */
typedef NS_ENUM(NSInteger, YSAnimationPopStyle) {
    YSAnimationPopStyleNO = 0,               ///< 无动画
    YSAnimationPopStyleScale,                ///< 缩放动画，先放大，后恢复至原大小
    YSAnimationPopStyleShakeFromTop,         ///< 从顶部掉下到中间晃动动画
    YSAnimationPopStyleShakeFromBottom,      ///< 从底部往上到中间晃动动画
    YSAnimationPopStyleShakeFromLeft,        ///< 从左侧往右到中间晃动动画
    YSAnimationPopStyleShakeFromRight,       ///< 从右侧往左到中间晃动动画
    YSAnimationPopStyleCardDropFromLeft,     ///< 卡片从顶部左侧开始掉落动画
    YSAnimationPopStyleCardDropFromRight,    ///< 卡片从顶部右侧开始掉落动画
    YSAnimationPopStyleScaleFromRight,       ///< 卡片从右侧开始放大动画
    YSAnimationPopStyleLineFromBottom,       ///< 平滑线性从底部推出来动画
    YSAnimationPopStyleLineFromRight,         ///< 平滑线性从右侧推出来动画
    YSAnimationPopStyleLineFromTop,       ///< 平滑线性从顶部推出来动画

};

/**
 移除时动画弹框样式
 */
typedef NS_ENUM(NSInteger, YSAnimationDismissStyle) {
    YSAnimationDismissStyleNO = 0,               ///< 无动画
    YSAnimationDismissStyleScale,                ///< 缩放动画
    YSAnimationDismissStyleDropToTop,            ///< 从中间直接掉落到顶部
    YSAnimationDismissStyleDropToBottom,         ///< 从中间直接掉落到底部
    YSAnimationDismissStyleDropToLeft,           ///< 从中间直接掉落到左侧
    YSAnimationDismissStyleDropToRight,          ///< 从中间直接掉落到右侧
    YSAnimationDismissStyleCardDropToLeft,       ///< 卡片从中间往左侧掉落
    YSAnimationDismissStyleCardDropToRight,      ///< 卡片从中间往右侧掉落
    YSAnimationDismissStyleCardDropToTop,        ///< 卡片从中间往顶部移动消失
    YSAnimationDismissStyleLineToBottom,         ///< 平滑线性掉落到底部动画
    YSAnimationDismissStyleLineToRight,           ///< 平滑线性从右侧消失动画
    YSAnimationDismissStyleLineToTop,           ///< 平滑线性从顶部消失动画

};

@interface UCBaseAnimationPopView : UIView
/** 显示时点击背景是否移除弹框，默认为YES。 如果为YES会有一个半透明黑色的蒙版*/
@property (nonatomic) BOOL isClickBGDismiss;
/** 显示时是否监听屏幕旋转，默认为NO */
@property (nonatomic) BOOL isObserverOrientationChange;
/** 显示时背景的透明度，取值(0.0~1.0)，默认为0.5 */
@property (nonatomic) CGFloat popBGAlpha;

/// 动画相关属性参数
/** 显示时动画时长，>= 0。不设置则使用默认的动画时长 */
@property (nonatomic) CGFloat popAnimationDuration;
/** 隐藏时动画时长，>= 0。不设置则使用默认的动画时长 */
@property (nonatomic) CGFloat dismissAnimationDuration;
/** 显示完成回调 */
@property (nullable, nonatomic, copy) void(^popComplete)(void);
/** 移除完成回调 */
@property (nullable, nonatomic, copy) void(^dismissComplete)(void);


@property (nonatomic, assign) BOOL ispoping;

/**
 通过自定义视图来构造弹框视图
 
 @param customView 自定义视图
 */
- (nullable instancetype)initWithCustomView:(UIView *_Nonnull)customView
                                   popStyle:(YSAnimationPopStyle)popStyle
                               dismissStyle:(YSAnimationDismissStyle)dismissStyle;

/**
通过自定义视图来构造弹框视图
默认弹出动画是YSAnimationPopStyleLineFromBottom,       ///< 平滑线性从底部推出来动画
默认消失动画是YSAnimationDismissStyleLineToBottom,         ///< 平滑线性掉落到底部动画
@param customView 自定义视图
*/
- (nullable instancetype)initWithCustomView:(UIView *_Nonnull)customView;

/**
 显示弹框
 */
- (void)pop;

/**
 移除弹框
 */
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
