//
//  ARDSettingVolumeTableViewCell.h
//  AppRTCMobile-iOS
//
//  Created by user on 2022/7/25.
//  Copyright © 2022 Bang Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ARDSettingVolumeTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *volumeLabel;
@property (nonatomic, strong)UIButton *addButton;
@property (nonatomic, strong)UIButton *reduceButton;
@property (nonatomic, strong)UIButton *muteButton;

@property (nonatomic, strong)void(^clickVolumeBlock)(int num);
@end

NS_ASSUME_NONNULL_END
