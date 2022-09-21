//
//  UPhoneTouchButton.m
//  AppRTCMobile-iOS
//
//  Created by user on 2021/10/22.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import "UPhoneTouchButton.h"
#import "UCCommon.h"
@implementation UPhoneTouchButton
@synthesize MoveEnable;
@synthesize MoveEnabled;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
//开始触摸的方法
//触摸-清扫
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    MoveEnabled = NO;
    [super touchesBegan:touches withEvent:event];
    if (!MoveEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    beginpoint = [touch locationInView:self];
}

//触摸移动的方法

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
  
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    //偏移量
    float offsetX = currentPosition.x - beginpoint.x;
    float offsetY = currentPosition.y - beginpoint.y;
    if (fabsf(offsetX) > 5 || fabsf(offsetY) > 5) {//防止滑动点击出现设置界面
        MoveEnabled = YES;//单击事件可用
        if (!MoveEnable) {
            return;
        }
    }else{
        MoveEnabled = NO;
        return;
        
    }
    
    //移动后的中心坐标
    self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
    
    //x轴左右极限坐标
    if (self.center.x > (self.superview.frame.size.width-self.frame.size.width/2))
    {
        CGFloat x = self.superview.frame.size.width-self.frame.size.width/2;
        self.center = CGPointMake(x, self.center.y + offsetY);
    }else if (self.center.x < self.frame.size.width/2)
    {
        CGFloat x = self.frame.size.width/2;
        self.center = CGPointMake(x, self.center.y + offsetY);
    }
    
    //y轴上下极限坐标
    if (self.center.y > (self.superview.frame.size.height - distance_bottom -self.frame.size.height/2)) {
        CGFloat x = self.center.x;
        CGFloat y = self.superview.frame.size.height-self.frame.size.height/2;
        self.center = CGPointMake(x, y - distance_bottom);
    }else if (self.center.y <= self.frame.size.height/2 + KKNavBarHeight - 50){
        CGFloat x = self.center.x;
        CGFloat y = self.frame.size.height/2;
        self.center = CGPointMake(x, y + KKNavBarHeight - 50);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!MoveEnable) {
        return;
    }
    //不加此句话，UIButton将一直处于按下状态
    [super touchesEnded: touches withEvent: event];
    
}

//外界因素取消touch事件，如进入电话
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}


@end
