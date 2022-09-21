//
//  UPhoneSettingOperationTableViewCell.h
//  AppRTCMobile-iOS
//
//  Created by user on 2021/12/29.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UPhoneSettingOperationTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *operationLabel;
@property (nonatomic, strong)UIButton *taskListButton;
@property (nonatomic, strong)UIButton *homeButton;
@property (nonatomic, strong)UIButton *backButton;

@property (nonatomic, strong)void(^clickOperationBlock)(NSString *str);
@end

NS_ASSUME_NONNULL_END
