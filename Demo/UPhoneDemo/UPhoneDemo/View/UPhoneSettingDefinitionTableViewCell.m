//
//  UPhoneSettingDefinitionTableViewCell.m
//  AppRTCMobile-iOS
//
//  Created by user on 2021/12/27.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import "UPhoneSettingDefinitionTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UCCommon.h"
@implementation UPhoneSettingDefinitionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.definitionLabel];
        [self.contentView addSubview:self.superButton];
        [self.contentView addSubview:self.highButton];
        [self.contentView addSubview:self.lowButton];
        self.contentView.backgroundColor = RGBA(43, 51, 60, 1);

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_definitionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    
    [_superButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.definitionLabel.mas_bottom).offset(10);
        make.height.equalTo(@28);
        make.width.equalTo(@60);
    }];
    
    [_highButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.superButton.mas_right).offset((self.contentView.frame.size.width - 220)/2);
        make.top.equalTo(self.definitionLabel.mas_bottom).offset(10);
        make.height.equalTo(@28);
        make.width.equalTo(@60);
    }];
    
    [_lowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.highButton.mas_right).offset((self.contentView.frame.size.width - 220)/2);
        make.top.equalTo(self.definitionLabel.mas_bottom).offset(10);
        make.height.equalTo(@28);
        make.width.equalTo(@60);
    }];
}


- (UILabel *)definitionLabel {
    if (!_definitionLabel) {
        _definitionLabel = [[UILabel alloc]init];
        _definitionLabel.text = @"画质";
        _definitionLabel.font = [UIFont systemFontOfSize:13];
        _definitionLabel.textColor = [UIColor whiteColor];
    }
    return _definitionLabel;
}

- (UIButton *)superButton {
    if (!_superButton) {
        _superButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _superButton.layer.masksToBounds = YES;
        _superButton.layer.cornerRadius = 13;
        _superButton.layer.borderColor = RGBA(134, 139, 150, 1).CGColor;
        _superButton.layer.borderWidth = 0.5;
        [_superButton setTitle:@"超清" forState:UIControlStateNormal];
        [_superButton setTitleColor:RGBA(134, 139, 150, 1) forState:UIControlStateNormal];
        [_superButton setTitleColor:RGBA(89, 193, 132, 1) forState:UIControlStateSelected];
        _superButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_superButton addTarget:self action:@selector(definitionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _superButton;
}

- (UIButton *)highButton {
    if (!_highButton) {
        _highButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _highButton.layer.masksToBounds = YES;
        _highButton.layer.cornerRadius = 13;
        _highButton.layer.borderWidth = 0.5;
        _highButton.layer.borderColor = RGBA(134, 139, 150, 1).CGColor;
        [_highButton setTitle:@"高清" forState:UIControlStateNormal];
        [_highButton setTitleColor:RGBA(134, 139, 150, 1) forState:UIControlStateNormal];
        [_highButton setTitleColor:RGBA(89, 193, 132, 1) forState:UIControlStateSelected];
        _highButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_highButton addTarget:self action:@selector(definitionClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _highButton;
}

- (UIButton *)lowButton {
    if (!_lowButton) {
        _lowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _lowButton.layer.masksToBounds = YES;
        _lowButton.layer.cornerRadius = 13;
        _lowButton.layer.borderColor = RGBA(134, 139, 150, 1).CGColor;
        _lowButton.layer.borderWidth = 0.5;
        [_lowButton setTitle:@"标清" forState:UIControlStateNormal];
        [_lowButton setTitleColor:RGBA(134, 139, 150, 1) forState:UIControlStateNormal];
        [_lowButton setTitleColor:RGBA(89, 193, 132, 1) forState:UIControlStateSelected];
        _lowButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_lowButton addTarget:self action:@selector(definitionClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _lowButton;
}

- (void)definitionClick:(UIButton *)sender {
    if (sender == _superButton) {
        _superButton.selected = YES;
        _superButton.backgroundColor = RGBA(45, 65, 70, 1);
        _superButton.layer.borderColor = RGBA(89, 193, 132, 1).CGColor;
        _highButton.selected = NO;
        _highButton.backgroundColor = [UIColor clearColor];
        _highButton.layer.borderColor = RGBA(134, 139, 150, 1).CGColor;
        _lowButton.selected = NO;
        _lowButton.backgroundColor = [UIColor clearColor];
        _lowButton.layer.borderColor = RGBA(134, 139, 150, 1).CGColor;
        
        
        if (self.clickDefinitionBlock) {
            self.clickDefinitionBlock(6);
        }
        
        //暂时
        
        [[NSUserDefaults standardUserDefaults] setObject:@"超清" forKey:@"test_Definition"];

    }else if (sender == _highButton){
        _highButton.selected = YES;
        _highButton.backgroundColor = RGBA(45, 65, 70, 1);
        _highButton.layer.borderColor = RGBA(89, 193, 132, 1).CGColor;
        _superButton.selected = NO;
        _superButton.backgroundColor = [UIColor clearColor];
        _superButton.layer.borderColor = RGBA(134, 139, 150, 1).CGColor;
        _lowButton.selected = NO;
        _lowButton.backgroundColor = [UIColor clearColor];
        _lowButton.layer.borderColor = RGBA(134, 139, 150, 1).CGColor;
        if (self.clickDefinitionBlock) {
            self.clickDefinitionBlock(3);
        }
        [[NSUserDefaults standardUserDefaults] setObject:@"高清" forKey:@"test_Definition"];

    }else{
        _lowButton.selected = YES;
        _lowButton.backgroundColor = RGBA(45, 65, 70, 1);
        _lowButton.layer.borderColor = RGBA(89, 193, 132, 1).CGColor;
        _highButton.selected = NO;
        _highButton.backgroundColor = [UIColor clearColor];
        _highButton.layer.borderColor = RGBA(134, 139, 150, 1).CGColor;
        _superButton.selected = NO;
        _superButton.backgroundColor = [UIColor clearColor];
        _superButton.layer.borderColor = RGBA(134, 139, 150, 1).CGColor;
        
        if (self.clickDefinitionBlock) {
            self.clickDefinitionBlock(0);
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:@"标清" forKey:@"test_Definition"];

    }
}
@end
