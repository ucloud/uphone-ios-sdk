//
//  UPhoneSettingSwitchLiveTableViewCell.h
//  AppRTCMobile-iOS
//
//  Created by user on 2021/12/29.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UPhoneSettingSwitchLiveTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *starLabel;
@property (nonatomic, strong)UISwitch *chooseSwitch;
@property (nonatomic, strong)UITextField *liveTextField;
@property (nonatomic, copy)void(^clickSwitchChooseBlock)(BOOL isSwitch,NSString *rtmpUrl);
@end

NS_ASSUME_NONNULL_END
