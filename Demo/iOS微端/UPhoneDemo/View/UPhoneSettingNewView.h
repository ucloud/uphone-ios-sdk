//
//  UPhoneSettingNewView.h
//  AppRTCMobile-iOS
//
//  Created by user on 2021/12/27.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPhoneBaseView.h"
#import "UPhonePacketLostView.h"
NS_ASSUME_NONNULL_BEGIN

@interface UPhoneSettingNewView : UPhoneBaseView
@property (nonatomic, strong)UPhonePacketLostView *statusView;

@property (nonatomic, copy)void(^clickchooseDelayButtonBlock)(BOOL isSelect);

@property (nonatomic, copy)void(^clickDefinitionButtonBlock)(int resolution);

@property (nonatomic, copy)void(^clickChooseHandButtonBlock)(BOOL isSelect);

@property (nonatomic, copy)void(^clickChooseLiveButtonBlock)(BOOL isSelect,NSString *rtmpUrl);

@property (nonatomic, copy)void(^clickChooseScreenButtonBlock)(void);

@property (nonatomic, copy)void(^clickChoosePacketButtonBlock)(BOOL isSelect);

@property (nonatomic, copy)void(^clickChooseMuteButtonBlock)(BOOL isSelect);

@property (nonatomic, copy)void(^clickOperationButtonBlock)(NSString *str);

@property (nonatomic, copy)void(^clickExitButtonBlock)(void);

@property (nonatomic, copy)void(^clickShowDelayOrPacketBlock)(BOOL isSelect);

@property (nonatomic, copy)void(^clickShowNetworkBlock)(BOOL isSelect);

@property (nonatomic, copy)void(^clickTestButtonBlock)(void);

@property (nonatomic, copy)void(^clickVolumeButtonBlock)(int num);

@end

NS_ASSUME_NONNULL_END
