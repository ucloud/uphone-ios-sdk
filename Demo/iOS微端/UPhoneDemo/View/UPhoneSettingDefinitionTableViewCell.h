//
//  UPhoneSettingDefinitionTableViewCell.h
//  AppRTCMobile-iOS
//
//  Created by user on 2021/12/27.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UPhoneSettingDefinitionTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *definitionLabel;
@property (nonatomic, strong)UIButton *superButton;
@property (nonatomic, strong)UIButton *highButton;
@property (nonatomic, strong)UIButton *lowButton;

@property (nonatomic, strong)void(^clickDefinitionBlock)(int resolution);
@end

NS_ASSUME_NONNULL_END
