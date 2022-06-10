//
//  UPhoneNavigationView.m
//  AppRTCMobile-iOS
//
//  Created by user on 2021/10/29.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import "UPhoneNavigationView.h"
#import "UCCommon.h"
@implementation UPhoneNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        self.backgroundColor = [UIColor colorWithRed:33.0/255.0 green:33.0/255.0 blue:33.0/255.0 alpha:1.0];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, KKNavBarHeight - 35, [UIScreen mainScreen].bounds.size.width, 20);
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"UCloud Game";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
