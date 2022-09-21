//
//  UCBaseAnimationPopView.m
//  CQLives
//
//  Created by user on 2020/4/28.
//  Copyright © 2020 鹿达令. All rights reserved.
//

#import "UCBaseAnimationPopView.h"
#import "UCCommon.h"
// 角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

/// 无论支不支持横屏，只要设备横屏了，就会返回YES
#define IS_DEVICE_LANDSCAPE UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])

@interface UCBaseAnimationPopView ()<UIGestureRecognizerDelegate>

/** 内容视图 */
@property (nonatomic, strong) UIView *contentView;
/** 背景层 */
@property (nonatomic, strong) UIView *backgroundView;
/** 自定义视图 */
@property (nonatomic, strong) UIView *customView;
/** 显示时动画弹框样式 */
@property (nonatomic) YSAnimationPopStyle animationPopStyle;
/** 移除时动画弹框样式 */
@property (nonatomic) YSAnimationDismissStyle animationDismissStyle;
/** 显示时背景是否透明，透明度是否为<= 0，默认为NO */
@property (nonatomic) BOOL isTransparent;

@end

@implementation UCBaseAnimationPopView

- (nullable instancetype)initWithCustomView:(UIView *_Nonnull)customView {
    return [self initWithCustomView:customView popStyle:YSAnimationPopStyleLineFromBottom dismissStyle:YSAnimationDismissStyleLineToBottom];
}

- (nullable instancetype)initWithCustomView:(UIView *_Nonnull)customView
                                   popStyle:(YSAnimationPopStyle)popStyle
                               dismissStyle:(YSAnimationDismissStyle)dismissStyle
{
    // 检测自定义视图是否存在(check customView is exist)
    if (!customView) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _ispoping = NO;
        _isClickBGDismiss = YES;
        _isObserverOrientationChange = NO;
        _popBGAlpha = 0.3f;
        _isTransparent = NO;
        _customView = customView;
        _animationPopStyle = popStyle;
        _animationDismissStyle = dismissStyle;
        _popAnimationDuration = -0.1f;
        _dismissAnimationDuration = -0.1f;
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.0f;
        [self addSubview:_backgroundView];
        
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBGLayer:)];
        tap.delegate = self;
        [_contentView addGestureRecognizer:tap];
        
        if (_animationPopStyle == YSAnimationPopStyleLineFromBottom) {
            CGFloat customViewY = CGRectGetMaxY(self.frame) - self.customView.frame.size.height; // 812 - 250
            CGFloat customViewCenterY = customViewY + self.customView.frame.size.height * 0.5;
            customView.center = CGPointMake(_contentView.center.x, customViewCenterY);
        }
        else if (_animationPopStyle == YSAnimationPopStyleLineFromRight) {
            
        }else if (_animationPopStyle == YSAnimationPopStyleLineFromTop) {
            CGFloat customViewY = KKNavBarHeight2;
            CGFloat customViewCenterY = customViewY + self.customView.frame.size.height * 0.5;
            customView.center = CGPointMake(_contentView.center.x, customViewCenterY);
        }
        else if (_animationPopStyle == YSAnimationPopStyleShakeFromRight){//暂时
//            if (IS_DEVICE_LANDSCAPE) {
//                customView.left = self.width-self.customView.width-TabBarSafeBottom;
//            }else {
//                customView.left = self.width-self.customView.width;
//            }
            
        }
        else {
            customView.center = _contentView.center;
        }
        [_contentView addSubview:customView];
    }
    return self;
}

- (void)setIsObserverOrientationChange:(BOOL)isObserverOrientationChange
{
    _isObserverOrientationChange = isObserverOrientationChange;
    
    if (_isObserverOrientationChange) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    }
}

- (void)setPopBGAlpha:(CGFloat)popBGAlpha
{
    _popBGAlpha = (popBGAlpha <= 0.0f) ? 0.0f : ((popBGAlpha > 1.0) ? 1.0 : popBGAlpha);
    _isTransparent = (_popBGAlpha == 0.0f);
}

#pragma mark 点击背景(Click background)
- (void)tapBGLayer:(UITapGestureRecognizer *)tap
{
    if (_isClickBGDismiss) {
        [self dismiss];
    }
}

#pragma mark UIGestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint location = [touch locationInView:_contentView];
    location = [_customView.layer convertPoint:location fromLayer:_contentView.layer];
    return ![_customView.layer containsPoint:location];
}

- (void)pop
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    __weak typeof(self) ws = self;
    NSTimeInterval defaultDuration = [self getPopDefaultDuration:self.animationPopStyle];
    NSTimeInterval duration = (_popAnimationDuration < 0.0f) ? defaultDuration : _popAnimationDuration;
    if (self.animationPopStyle == YSAnimationPopStyleNO) {
        self.alpha = 0.0;
        if (self.isTransparent) {
            self.backgroundView.backgroundColor = [UIColor clearColor];
        } else {
            self.backgroundView.alpha = 0.0;
        }
        [UIView animateWithDuration:duration animations:^{
            ws.alpha = 1.0;
            if (!ws.isTransparent) {
                ws.backgroundView.alpha = ws.popBGAlpha;
            }
        }];
    } else {
        if (ws.isTransparent) {
            self.backgroundView.backgroundColor = [UIColor clearColor];
        } else {
            self.backgroundView.alpha = 0.0;
            [UIView animateWithDuration:duration * 0.5 animations:^{
                ws.backgroundView.alpha = ws.popBGAlpha;
            }];
        }
        [self hanlePopAnimationWithDuration:duration];
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (ws.popComplete) {
            ws.popComplete();
        }
    });
    self.ispoping = YES;
}

- (void)dismiss
{
    __weak typeof(self) ws = self;
    NSTimeInterval defaultDuration = [self getDismissDefaultDuration:self.animationDismissStyle];
    NSTimeInterval duration = (_dismissAnimationDuration < 0.0f) ? defaultDuration : _dismissAnimationDuration;
    if (self.animationDismissStyle == YSAnimationPopStyleNO) {
        [UIView animateWithDuration:duration animations:^{
            ws.alpha = 0.0;
            ws.backgroundView.alpha = 0.0;
        }];
    } else {
        if (!ws.isTransparent) {
            [UIView animateWithDuration:duration * 0.5 animations:^{
                ws.backgroundView.alpha = 0.0;
            }];
        }
        [self hanleDismissAnimationWithDuration:duration];
    }
    
    if (ws.isObserverOrientationChange) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (ws.dismissComplete) {
            ws.dismissComplete();
        }
        [ws removeFromSuperview];
    });
    
    // Immediately respond to other places with animated dismiss
    self.frame = CGRectZero;
    self.ispoping = NO;
}

- (void)hanlePopAnimationWithDuration:(NSTimeInterval)duration
{
    __weak typeof(self) ws = self;
    switch (self.animationPopStyle) {
        case YSAnimationPopStyleScale:
        {
            [self animationWithLayer:self.contentView.layer duration:duration values:@[@0.0, @1.2, @1.0]]; // 另外一组动画值(the other animation values) @[@0.0, @1.2, @0.9, @1.0]
        }
            break;
        case YSAnimationPopStyleScaleFromRight:
        {
            [self animationWithLayer:self.contentView.layer duration:duration values:@[@0.0, @1.0] anchorPoint:CGPointMake(1.0, 0)];
        }
            break;
        case YSAnimationPopStyleShakeFromTop:
        case YSAnimationPopStyleShakeFromBottom:
        case YSAnimationPopStyleShakeFromLeft:
        case YSAnimationPopStyleShakeFromRight:
        {
            CGPoint startPosition = self.contentView.layer.position;
            if (self.animationPopStyle == YSAnimationPopStyleShakeFromTop) {
                self.contentView.layer.position = CGPointMake(startPosition.x, -startPosition.y);
            } else if (self.animationPopStyle == YSAnimationPopStyleShakeFromBottom) {
                self.contentView.layer.position = CGPointMake(startPosition.x, CGRectGetMaxY(self.frame) + startPosition.y);
            } else if (self.animationPopStyle == YSAnimationPopStyleShakeFromLeft) {
                self.contentView.layer.position = CGPointMake(-startPosition.x, startPosition.y);
            } else {
                self.contentView.layer.position = CGPointMake(CGRectGetMaxX(self.frame) + startPosition.x, startPosition.y);
            }

            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                ws.contentView.layer.position = startPosition;
            } completion:nil];
        }
            break;
        case YSAnimationPopStyleCardDropFromLeft:
        case YSAnimationPopStyleCardDropFromRight:
        {
            CGPoint startPosition = self.contentView.layer.position;
            if (self.animationPopStyle == YSAnimationPopStyleCardDropFromLeft) {
                self.contentView.layer.position = CGPointMake(startPosition.x * 1.0, -startPosition.y);
                self.contentView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(15.0));
            } else {
                self.contentView.layer.position = CGPointMake(startPosition.x * 1.0, -startPosition.y);
                self.contentView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-15.0));
            }
            
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                ws.contentView.layer.position = startPosition;
            } completion:nil];
            
            [UIView animateWithDuration:duration*0.6 animations:^{
                ws.contentView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS((ws.animationPopStyle == YSAnimationPopStyleCardDropFromRight) ? 5.5 : -5.5), 0, 0, 0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration*0.2 animations:^{
                    ws.contentView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS((ws.animationPopStyle == YSAnimationPopStyleCardDropFromRight) ? -1.0 : 1.0));
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:duration*0.2 animations:^{
                        ws.contentView.transform = CGAffineTransformMakeRotation(0.0);
                    } completion:nil];
                }];
            }];
        }
            break;
        case YSAnimationPopStyleLineFromBottom:
        {
            CGPoint startPosition = self.contentView.layer.position;
            self.contentView.layer.position = CGPointMake(startPosition.x, CGRectGetMaxY(self.frame) + startPosition.y);
            [UIView animateWithDuration:duration animations:^{
                ws.contentView.layer.position = startPosition;
            }];
        }
            break;
        case YSAnimationPopStyleLineFromRight:
        {
            CGPoint startPosition = self.contentView.layer.position;
            self.contentView.layer.position = CGPointMake(CGRectGetMaxX(self.frame) + startPosition.x, startPosition.y);
            [UIView animateWithDuration:duration animations:^{
                ws.contentView.layer.position = startPosition;
            }];
        }
            break;
        case YSAnimationPopStyleLineFromTop:
        {
            CGPoint startPosition = self.contentView.layer.position;
            self.contentView.layer.position = CGPointMake(startPosition.x, -startPosition.y);
            [UIView animateWithDuration:duration animations:^{
                ws.contentView.layer.position = startPosition;
            }];
        }
            break;
        default:
            break;
    }
}

- (void)hanleDismissAnimationWithDuration:(NSTimeInterval)duration
{
    __weak typeof(self) ws = self;
    switch (self.animationDismissStyle) {
        case YSAnimationDismissStyleScale:
        {
            [self animationWithLayer:self.contentView.layer duration:duration values:@[@1.0, @0.66, @0.33, @0.01]];
        }
            break;
        case YSAnimationDismissStyleDropToTop:
        case YSAnimationDismissStyleDropToBottom:
        case YSAnimationDismissStyleDropToLeft:
        case YSAnimationDismissStyleDropToRight:
        {
            CGPoint startPosition = self.contentView.layer.position;
            CGPoint endPosition = self.contentView.layer.position;
            if (self.animationDismissStyle == YSAnimationDismissStyleDropToTop) {
                endPosition = CGPointMake(startPosition.x, -startPosition.y);
            } else if (self.animationDismissStyle == YSAnimationDismissStyleDropToBottom) {
                endPosition = CGPointMake(startPosition.x, CGRectGetMaxY(self.frame) + startPosition.y);
            } else if (self.animationDismissStyle == YSAnimationDismissStyleDropToLeft) {
                endPosition = CGPointMake(-startPosition.x, startPosition.y);
            } else {
                endPosition = CGPointMake(CGRectGetMaxX(self.frame) + startPosition.x, startPosition.y);
            }
            
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                ws.contentView.layer.position = endPosition;
            } completion:nil];
        }
            break;
        case YSAnimationDismissStyleCardDropToLeft:
        case YSAnimationDismissStyleCardDropToRight:
        {
            CGPoint startPosition = self.contentView.layer.position;
            BOOL isLandscape = UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
            __block CGFloat rotateEndY = 0.0f;
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                if (self.animationDismissStyle == YSAnimationDismissStyleCardDropToLeft) {
                    ws.contentView.transform = CGAffineTransformMakeRotation(M_1_PI * 0.75);
                    if (isLandscape) rotateEndY = fabs(ws.contentView.frame.origin.y);
                    ws.contentView.layer.position = CGPointMake(startPosition.x, CGRectGetMaxY(ws.frame) + startPosition.y + rotateEndY);
                } else {
                    ws.contentView.transform = CGAffineTransformMakeRotation(-M_1_PI * 0.75);
                    if (isLandscape) rotateEndY = fabs(ws.contentView.frame.origin.y);
                    ws.contentView.layer.position = CGPointMake(startPosition.x * 1.25, CGRectGetMaxY(ws.frame) + startPosition.y + rotateEndY);
                }
            } completion:nil];
        }
            break;
        case YSAnimationDismissStyleCardDropToTop:
        {
            CGPoint startPosition = self.contentView.layer.position;
            CGPoint endPosition = CGPointMake(startPosition.x, -startPosition.y);
            [UIView animateWithDuration:duration*0.2 animations:^{
                ws.contentView.layer.position = CGPointMake(startPosition.x, startPosition.y + 50.0f);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration*0.8 animations:^{
                    ws.contentView.layer.position = endPosition;
                } completion:nil];
            }];
        }
            break;
        case YSAnimationDismissStyleLineToBottom:
        {
            CGPoint startPosition = self.contentView.layer.position;
            CGPoint endPosition = CGPointMake(startPosition.x, CGRectGetMaxY(self.frame) + startPosition.y);
            [UIView animateWithDuration:duration animations:^{
                ws.contentView.layer.position = endPosition;
            }];
        }
            break;
        case YSAnimationDismissStyleLineToRight:
        {
            CGPoint startPosition = self.contentView.layer.position;
            CGPoint endPosition = CGPointMake(CGRectGetMaxX(self.frame) + startPosition.x, startPosition.y);
            [UIView animateWithDuration:duration animations:^{
                ws.contentView.layer.position = endPosition;
            }];
        }
            break;
        case YSAnimationDismissStyleLineToTop:
        {
            CGPoint startPosition = self.contentView.layer.position;
            CGPoint endPosition = CGPointMake(startPosition.x,  -startPosition.y);
            [UIView animateWithDuration:duration animations:^{
                ws.contentView.layer.position = endPosition;
            }];
        }
            break;
        default:
            break;
    }
}

- (NSTimeInterval)getPopDefaultDuration:(YSAnimationPopStyle)animationPopStyle
{
    NSTimeInterval defaultDuration = 0.0f;
    if (animationPopStyle == YSAnimationPopStyleNO) {
        defaultDuration = 0.2f;
    } else if (animationPopStyle == YSAnimationPopStyleScale ||
               animationPopStyle == YSAnimationPopStyleLineFromBottom ||
               animationPopStyle == YSAnimationPopStyleScaleFromRight ||
               animationPopStyle == YSAnimationPopStyleLineFromRight || animationPopStyle == YSAnimationPopStyleLineFromTop ) {
        defaultDuration = 0.3f;
    } else if (animationPopStyle == YSAnimationPopStyleShakeFromTop ||
               animationPopStyle == YSAnimationPopStyleShakeFromBottom ||
               animationPopStyle == YSAnimationPopStyleShakeFromLeft ||
               animationPopStyle == YSAnimationPopStyleShakeFromRight ||
               animationPopStyle == YSAnimationPopStyleCardDropFromLeft ||
               animationPopStyle == YSAnimationPopStyleCardDropFromRight) {
        defaultDuration = 0.8f;
    }
    return defaultDuration;
}

- (NSTimeInterval)getDismissDefaultDuration:(YSAnimationDismissStyle)animationDismissStyle
{
    NSTimeInterval defaultDuration = 0.0f;
    if (animationDismissStyle == YSAnimationDismissStyleNO ||
        animationDismissStyle == YSAnimationDismissStyleScale) {
        defaultDuration = 0.2f;
    } else if (animationDismissStyle == YSAnimationDismissStyleLineToBottom ||
               animationDismissStyle == YSAnimationDismissStyleLineToRight || YSAnimationDismissStyleLineToTop) {
        defaultDuration = 0.3f;
    } else if (animationDismissStyle == YSAnimationDismissStyleDropToTop ||
               animationDismissStyle == YSAnimationDismissStyleDropToBottom ||
               animationDismissStyle == YSAnimationDismissStyleDropToLeft ||
               animationDismissStyle == YSAnimationDismissStyleDropToRight ||
               animationDismissStyle == YSAnimationDismissStyleCardDropToLeft ||
               animationDismissStyle == YSAnimationDismissStyleCardDropToRight ||
               animationDismissStyle == YSAnimationDismissStyleCardDropToTop) {
        defaultDuration = 0.8f;
    }
    return defaultDuration;
}

- (void)animationWithLayer:(CALayer *)layer duration:(CGFloat)duration values:(NSArray *)values
{
    [self animationWithLayer:layer duration:duration values:values anchorPoint:CGPointMake(0.5, 0.5)];
}

- (void)animationWithLayer:(CALayer *)layer duration:(CGFloat)duration values:(NSArray *)values anchorPoint:(CGPoint)anchorPoint
{
   CAKeyframeAnimation *KFAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
   KFAnimation.duration = duration;
   KFAnimation.removedOnCompletion = NO;
   KFAnimation.fillMode = kCAFillModeForwards;
   
   NSMutableArray *valueArr = [NSMutableArray arrayWithCapacity:values.count];
   for (NSUInteger i = 0; i<values.count; i++) {
       CGFloat scaleValue = [values[i] floatValue];
       [valueArr addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(scaleValue, scaleValue, scaleValue)]];
   }
   KFAnimation.values = valueArr;
   KFAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
   [self setAnchorPoint:anchorPoint forView:self.contentView];
   [layer addAnimation:KFAnimation forKey:nil];
}

- (void) setAnchorPoint:(CGPoint)anchorpoint forView:(UIView *)view{
  CGRect oldFrame = view.frame;
  view.layer.anchorPoint = anchorpoint;
  view.frame = oldFrame;
}

#pragma mark 监听横竖屏方向改变
- (void)statusBarOrientationChange:(NSNotification *)notification
{
    CGRect startCustomViewRect = self.customView.frame;
    self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    self.backgroundView.frame = self.bounds;
    self.contentView.frame = self.bounds;
    self.customView.frame = startCustomViewRect;
    self.customView.center = self.center;
}


@end
