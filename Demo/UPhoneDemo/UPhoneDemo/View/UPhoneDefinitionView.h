//
//  UPhoneDefinitionView.h
//  AppRTCMobile-iOS
//
//  Created by user on 2021/10/22.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UPhoneDefinitionView : UIView
@property (nonatomic, strong)UIButton *clickButton;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, copy)void(^clickButtonBlock)(void);
@end

NS_ASSUME_NONNULL_END
