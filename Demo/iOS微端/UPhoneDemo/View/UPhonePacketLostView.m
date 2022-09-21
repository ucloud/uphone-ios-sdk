//
//  UPhonePacketLostView.m
//  AppRTCMobile-iOS
//
//  Created by user on 2021/12/7.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import "UPhonePacketLostView.h"

@implementation UPhonePacketLostView
{
    UILabel *_statsLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _statsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statsLabel.numberOfLines = 0;
        _statsLabel.font = [UIFont systemFontOfSize:8];
        _statsLabel.adjustsFontSizeToFitWidth = YES;
        _statsLabel.minimumScaleFactor = 0.6;
        _statsLabel.textColor = [UIColor whiteColor];
        _statsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_statsLabel];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.6];
    }
    return self;
}

- (void)setStats:(NSString *)stats {
    _statsLabel.text = stats;
}

- (void)layoutSubviews {
    _statsLabel.frame = self.bounds;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [_statsLabel sizeThatFits:size];
}

@end
