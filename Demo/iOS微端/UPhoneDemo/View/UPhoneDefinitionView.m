//
//  UPhoneDefinitionView.m
//  AppRTCMobile-iOS
//
//  Created by user on 2021/10/22.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import "UPhoneDefinitionView.h"

@implementation UPhoneDefinitionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.clickButton];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    float clickButtonHeight = 20;
    float clickButtonWidth = 20;
    float clickButtonX = 15;
    float clickButtonY = 0;
    self.clickButton.frame = CGRectMake(clickButtonX, clickButtonY, clickButtonWidth, clickButtonHeight);
    
    float titleLabelHeight = 20;
    float titleLabelWidth = 40;
    float titleLabelX = clickButtonX + 25;
    float titleLabelY = 0;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, titleLabelHeight);
    
}

- (UIButton *)clickButton {
    if (!_clickButton) {
        _clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clickButton addTarget:self action:@selector(clickButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_clickButton setImage:[UIImage imageNamed:@"select_button"] forState:UIControlStateSelected];
        [_clickButton setImage:[UIImage imageNamed:@"unselect_button"] forState:UIControlStateNormal];
    }
    return _clickButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _titleLabel;
}

- (void)clickButtonClick  {
    
    if (self.clickButtonBlock) {
        self.clickButtonBlock();
    }
    self.clickButton.selected = YES;
}
@end
