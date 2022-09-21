//
//  UPhoneSettingTableViewCell.m
//  AppRTCMobile-iOS
//
//  Created by user on 2021/12/27.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import "UPhoneSettingTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UCCommon.h"
@implementation UPhoneSettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.logoButton];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [_logoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.logoButton.mas_right).offset(10);
        make.height.equalTo(@20);
    }];

}
- (UIButton *)logoButton {
    if (!_logoButton) {
        _logoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    return _logoButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (void)setIsSelected:(BOOL)isSelected{
    if (isSelected) {
        _titleLabel.textColor = RGBA(89, 193, 132, 1);
        _logoButton.selected = YES;
    }else{
        _titleLabel.textColor = [UIColor whiteColor];
        _logoButton.selected = NO;
    }
}

@end
