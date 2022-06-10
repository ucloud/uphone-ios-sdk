//
//  UPhoneSettingFooterView.m
//  AppRTCMobile-iOS
//
//  Created by user on 2021/12/27.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import "UPhoneSettingFooterView.h"
#import <Masonry/Masonry.h>
#import "UCCommon.h"
@implementation UPhoneSettingFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.timeButton];
        [self addSubview:self.roomIdLabel];
        [self addSubview:self.buildLabel];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_buildLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@20);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    [_roomIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@20);
        make.bottom.equalTo(self.buildLabel.mas_top).offset(-10);
    }];
    [_timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.roomIdLabel.mas_top).offset(-10);
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        make.height.equalTo(@20);
    }];
}
- (UIButton *)timeButton {
    if (!_timeButton) {
        _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeButton setTitle:@"本日剩余限免：--" forState:UIControlStateNormal];
        _timeButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_timeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _timeButton.layer.masksToBounds = YES;
        _timeButton.layer.cornerRadius = 10;
        _timeButton.backgroundColor = RGBA(55, 66, 86, 1);
        
    }
    return _timeButton;
}

- (UILabel *)roomIdLabel {
    if (!_roomIdLabel) {
        _roomIdLabel = [[UILabel alloc]init];
        _roomIdLabel.textColor = [UIColor whiteColor];
        _roomIdLabel.font = [UIFont systemFontOfSize:13];
        _roomIdLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _roomIdLabel;
}

- (UILabel *)buildLabel {
    if (!_buildLabel) {
        _buildLabel = [[UILabel alloc]init];
        _buildLabel.textColor = [UIColor whiteColor];
        _buildLabel.font = [UIFont systemFontOfSize:13];
        _buildLabel.textAlignment = NSTextAlignmentCenter;
        _buildLabel.text = [NSString stringWithFormat:@"版本号：%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    }
    return _buildLabel;
}
@end
