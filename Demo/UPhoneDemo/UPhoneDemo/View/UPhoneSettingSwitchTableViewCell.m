//
//  UPhoneSettingSwitchTableViewCell.m
//  AppRTCMobile-iOS
//
//  Created by user on 2021/12/27.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//definition

#import "UPhoneSettingSwitchTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UCCommon.h"
@implementation UPhoneSettingSwitchTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.starLabel];
        [self.contentView addSubview:self.chooseSwitch];
        self.contentView.backgroundColor = RGBA(43, 51, 60, 1);

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.height.equalTo(@20);
    }];
    
    [_starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.titleLabel.mas_right).offset(3);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    [_chooseSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@40);
        make.width.equalTo(@60);
    }];
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"显示网络状态";
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel *)starLabel {
    if (!_starLabel) {
        _starLabel = [[UILabel alloc]init];
        _starLabel.text = @"*";
        _starLabel.font = [UIFont systemFontOfSize:13];
        _starLabel.textColor = [UIColor redColor];
    }
    return _starLabel;
}

- (UISwitch *)chooseSwitch{
    if (!_chooseSwitch) {
        _chooseSwitch = [[UISwitch alloc]init];
        _chooseSwitch.transform = CGAffineTransformMakeScale(0.7, 0.7);
        _chooseSwitch.thumbTintColor = [UIColor whiteColor];
        [_chooseSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _chooseSwitch;
}

- (void)switchAction:(UISwitch *)s1 {
    if (s1.on == YES) {
        if (self.clickSwitchChooseBlock) {
            self.clickSwitchChooseBlock(YES);
        }
    }else{
        if (self.clickSwitchChooseBlock) {
            self.clickSwitchChooseBlock(NO);
        }
    }
}
@end
