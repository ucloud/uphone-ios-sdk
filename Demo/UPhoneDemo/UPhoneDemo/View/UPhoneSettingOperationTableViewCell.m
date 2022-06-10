//
//  UPhoneSettingOperationTableViewCell.m
//  AppRTCMobile-iOS
//
//  Created by user on 2021/12/29.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import "UPhoneSettingOperationTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UCCommon.h"
@implementation UPhoneSettingOperationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.operationLabel];
        [self.contentView addSubview:self.taskListButton];
        [self.contentView addSubview:self.homeButton];
        [self.contentView addSubview:self.backButton];
        self.contentView.backgroundColor = RGBA(43, 51, 60, 1);
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_operationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    
    [_taskListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.operationLabel.mas_bottom).offset(10);
        make.height.equalTo(@28);
        make.width.equalTo(@60);
    }];
    
    [_homeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.taskListButton.mas_right).offset((self.contentView.frame.size.width - 220)/2);
        make.top.equalTo(self.operationLabel.mas_bottom).offset(10);
        make.height.equalTo(@28);
        make.width.equalTo(@60);
    }];
    
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.homeButton.mas_right).offset((self.contentView.frame.size.width - 220)/2);
        make.top.equalTo(self.operationLabel.mas_bottom).offset(10);
        make.height.equalTo(@28);
        make.width.equalTo(@60);
    }];
}


- (UILabel *)operationLabel {
    if (!_operationLabel) {
        _operationLabel = [[UILabel alloc]init];
        _operationLabel.text = @"控制";
        _operationLabel.font = [UIFont systemFontOfSize:13];
        _operationLabel.textColor = [UIColor whiteColor];
    }
    return _operationLabel;
}

- (UIButton *)taskListButton {
    if (!_taskListButton) {
        _taskListButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _taskListButton.layer.masksToBounds = YES;
        _taskListButton.layer.cornerRadius = 13;
        _taskListButton.layer.borderColor = RGBA(134, 139, 150, 1).CGColor;
        _taskListButton.layer.borderWidth = 0.5;
        [_taskListButton setTitle:@"清理后台" forState:UIControlStateNormal];
        [_taskListButton setTitleColor:RGBA(134, 139, 150, 1) forState:UIControlStateNormal];
        [_taskListButton setTitleColor:RGBA(89, 193, 132, 1) forState:UIControlStateSelected];
        _taskListButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_taskListButton addTarget:self action:@selector(definitionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _taskListButton;
}

- (UIButton *)homeButton {
    if (!_homeButton) {
        _homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _homeButton.layer.masksToBounds = YES;
        _homeButton.layer.cornerRadius = 13;
        _homeButton.layer.borderWidth = 0.5;
        _homeButton.layer.borderColor = RGBA(134, 139, 150, 1).CGColor;
        [_homeButton setTitle:@"回到桌面" forState:UIControlStateNormal];
        [_homeButton setTitleColor:RGBA(134, 139, 150, 1) forState:UIControlStateNormal];
        [_homeButton setTitleColor:RGBA(89, 193, 132, 1) forState:UIControlStateSelected];
        _homeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_homeButton addTarget:self action:@selector(definitionClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _homeButton;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.layer.masksToBounds = YES;
        _backButton.layer.cornerRadius = 13;
        _backButton.layer.borderColor = RGBA(134, 139, 150, 1).CGColor;
        _backButton.layer.borderWidth = 0.5;
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton setTitleColor:RGBA(134, 139, 150, 1) forState:UIControlStateNormal];
        [_backButton setTitleColor:RGBA(89, 193, 132, 1) forState:UIControlStateSelected];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_backButton addTarget:self action:@selector(definitionClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _backButton;
}
//0：清理后台 1：回到桌面 2：返回
- (void)definitionClick:(UIButton *)sender {
    if (sender == _taskListButton) {
        _taskListButton.selected = YES;
        _taskListButton.backgroundColor = RGBA(45, 65, 70, 1);
        _taskListButton.layer.borderColor = RGBA(89, 193, 132, 1).CGColor;
        if (self.clickOperationBlock) {
            self.clickOperationBlock(@"0");
        }
    }else if (sender == _homeButton){
        _homeButton.selected = YES;
        _homeButton.backgroundColor = RGBA(45, 65, 70, 1);
        _homeButton.layer.borderColor = RGBA(89, 193, 132, 1).CGColor;
        if (self.clickOperationBlock) {
            self.clickOperationBlock(@"1");
        }
    }else if (sender == _backButton){
        _backButton.selected = YES;
        _backButton.backgroundColor = RGBA(45, 65, 70, 1);
        _backButton.layer.borderColor = RGBA(89, 193, 132, 1).CGColor;
        if (self.clickOperationBlock) {
            self.clickOperationBlock(@"2");
        }
    }
}

@end
