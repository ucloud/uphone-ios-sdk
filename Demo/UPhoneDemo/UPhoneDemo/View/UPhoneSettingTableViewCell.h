//
//  UPhoneSettingTableViewCell.h
//  AppRTCMobile-iOS
//
//  Created by user on 2021/12/27.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UPhoneSettingTableViewCell : UITableViewCell
@property (nonatomic, strong)UIButton *logoButton;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, copy)void(^clickTitleButtonBlock)(void);
@end

NS_ASSUME_NONNULL_END
