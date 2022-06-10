//
//  UPhoneSettingSwitchTableViewCell.h
//  AppRTCMobile-iOS
//
//  Created by user on 2021/12/27.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UPhoneSettingSwitchTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *starLabel;
@property (nonatomic, strong)UISwitch *chooseSwitch;

@property (nonatomic, copy)void(^clickSwitchChooseBlock)(BOOL isSwitch);
@end

NS_ASSUME_NONNULL_END
