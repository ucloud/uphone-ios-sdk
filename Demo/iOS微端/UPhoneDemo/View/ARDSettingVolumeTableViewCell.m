//
//  ARDSettingVolumeTableViewCell.m
//  AppRTCMobile-iOS
//
//  Created by user on 2022/7/25.
//  Copyright © 2022 Bang Nguyen. All rights reserved.
//

#import "ARDSettingVolumeTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UCCommon.h"
@implementation ARDSettingVolumeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.volumeLabel];
        [self.contentView addSubview:self.addButton];
        [self.contentView addSubview:self.reduceButton];
//        [self.contentView addSubview:self.muteButton];
        self.contentView.backgroundColor = RGBA(43, 51, 60, 1);

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_volumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.volumeLabel.mas_bottom).offset(10);
        make.height.equalTo(@28);
        make.width.equalTo(@60);
    }];
    
    [_reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addButton.mas_right).offset((self.contentView.frame.size.width - 220)/2);
        make.top.equalTo(self.volumeLabel.mas_bottom).offset(10);
        make.height.equalTo(@28);
        make.width.equalTo(@60);
    }];
    
//    [_muteButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.reduceButton.mas_right).offset((self.contentView.frame.size.width - 220)/2);
//        make.top.equalTo(self.volumeLabel.mas_bottom).offset(10);
//        make.height.equalTo(@28);
//        make.width.equalTo(@60);
//    }];
}


- (UILabel *)volumeLabel {
    if (!_volumeLabel) {
        _volumeLabel = [[UILabel alloc]init];
        _volumeLabel.text = @"音量";
        _volumeLabel.font = [UIFont systemFontOfSize:13];
        _volumeLabel.textColor = [UIColor whiteColor];
    }
    return _volumeLabel;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.layer.masksToBounds = YES;
        _addButton.layer.cornerRadius = 13;
        _addButton.layer.borderColor = RGBA(134, 139, 150, 1).CGColor;
        _addButton.layer.borderWidth = 0.5;
        [_addButton setImage:[UIImage imageNamed:@"volume_up_unselect"] forState:UIControlStateNormal];
        [_addButton setImage:[UIImage imageNamed:@"volume_up_select"] forState:UIControlStateHighlighted];
        [_addButton setImageEdgeInsets:UIEdgeInsetsMake(4, 20, 4, 20)];
        [_addButton addTarget:self action:@selector(volumeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)reduceButton {
    if (!_reduceButton) {
        _reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reduceButton.layer.masksToBounds = YES;
        _reduceButton.layer.cornerRadius = 13;
        _reduceButton.layer.borderWidth = 0.5;
        _reduceButton.layer.borderColor = RGBA(134, 139, 150, 1).CGColor;
        [_reduceButton setImage:[UIImage imageNamed:@"volume_down_unselect"] forState:UIControlStateNormal];
        [_reduceButton setImage:[UIImage imageNamed:@"volume_down_select"] forState:UIControlStateHighlighted];
        [_reduceButton setImageEdgeInsets:UIEdgeInsetsMake(4, 20, 4, 20)];

        [_reduceButton addTarget:self action:@selector(volumeClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _reduceButton;
}

//- (UIButton *)muteButton {
//    if (!_muteButton) {
//        _muteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _muteButton.layer.masksToBounds = YES;
//        _muteButton.layer.cornerRadius = 13;
//        _muteButton.layer.borderColor = RGBA(134, 139, 150, 1).CGColor;
//        _muteButton.layer.borderWidth = 0.5;
//        [_reduceButton setImage:[UIImage imageNamed:@"volume_down_unselect"] forState:UIControlStateNormal];
//        [_reduceButton setImage:[UIImage imageNamed:@"volume_down_select"] forState:UIControlStateSelected];
//        [_muteButton addTarget:self action:@selector(volumeClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    }
//    return _muteButton;
//}

- (void)volumeClick:(UIButton *)sender {
    if (sender == _addButton) {
        if (self.clickVolumeBlock) {
            self.clickVolumeBlock(1);
        }
    }else if (sender == _reduceButton){
        if (self.clickVolumeBlock) {
            self.clickVolumeBlock(-1);
        }
    }
}

@end
