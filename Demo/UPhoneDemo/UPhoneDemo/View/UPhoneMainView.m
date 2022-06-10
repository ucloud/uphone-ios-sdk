/*
 *  Copyright 2015 The WebRTC Project Authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#import "UPhoneMainView.h"
#import "UPhoneNavigationView.h"

#import "UCCommon.h"
static CGFloat const kRoomTextFieldHeight = 40;
static CGFloat const kRoomTextFieldMargin = 20;
static CGFloat const kCallControlMargin = 8;

// Helper view that contains a text field and a clear button.
@interface ARDRoomTextField : UIView <UITextFieldDelegate>
@property(nonatomic, readonly) NSString *roomText;
@end

@implementation ARDRoomTextField {
    UITextField *_roomText;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _roomText = [[UITextField alloc] initWithFrame:CGRectZero];
        _roomText.borderStyle = UITextBorderStyleNone;
        _roomText.font = [UIFont boldSystemFontOfSize:20];
        _roomText.textColor = [UIColor whiteColor];
        _roomText.textAlignment = NSTextAlignmentCenter;
        _roomText.placeholder = @"请输入云手机id";
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:@"请输入云手机id" attributes:@{NSForegroundColorAttributeName :[UIColor grayColor]}];
        _roomText.tintColor = [UIColor colorWithRed:151.0/255.0 green:200.0/255.0 blue:196.0/255.0 alpha:1.0];
        _roomText.attributedPlaceholder = placeholderString;
        _roomText.autocorrectionType = UITextAutocorrectionTypeNo;
        _roomText.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _roomText.clearButtonMode = UITextFieldViewModeAlways;
        _roomText.returnKeyType = UIReturnKeyDone;
        _roomText.delegate = self;
        [self addSubview:_roomText];
        
    }
    return self;
}

- (void)layoutSubviews {
    _roomText.frame =
    CGRectMake(kRoomTextFieldMargin, 0, CGRectGetWidth(self.bounds) - kRoomTextFieldMargin,
               kRoomTextFieldHeight);
}

- (CGSize)sizeThatFits:(CGSize)size {
    size.height = kRoomTextFieldHeight;
    return size;
}

- (NSString *)roomText {
    return _roomText.text;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // There is no other control that can take focus, so manually resign focus
    // when return (Join) is pressed to trigger |textFieldDidEndEditing|.
    [textField resignFirstResponder];
    return YES;
}

@end

@implementation UPhoneMainView {
    ARDRoomTextField *_roomText;
    UIButton *_startRegularCallButton;
    UIButton *_startLoopbackCallButton;
    UIButton *_audioLoopButton;
    UIView *_blueView;
    UPhoneNavigationView *_navigationView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _navigationView = [[UPhoneNavigationView alloc]initWithFrame:CGRectZero];
        [self addSubview:_navigationView];
        _roomText = [[ARDRoomTextField alloc] initWithFrame:CGRectZero];
        [self addSubview:_roomText];
        _startRegularCallButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_startRegularCallButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _startRegularCallButton.backgroundColor
        = [UIColor colorWithRed:1.0 green:149.0/255.0 blue:0.0 alpha:1.0];
        _startRegularCallButton.clipsToBounds = YES;
        _startRegularCallButton.layer.cornerRadius = 20;
        [_startRegularCallButton setTitle:@"连接云手机" forState:UIControlStateNormal];
        [_startRegularCallButton addTarget:self
                                    action:@selector(onStartRegularCall:)
                          forControlEvents:UIControlEventTouchUpInside];
        _startRegularCallButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:_startRegularCallButton];
    
        self.backgroundColor = [UIColor colorWithRed:48.0/255.0 green:48.0/255.0 blue:48.0/255.0 alpha:1.0];
        _blueView = [[UIView alloc]initWithFrame:CGRectZero];
        _blueView.backgroundColor = [UIColor colorWithRed:151.0/255.0 green:200.0/255.0 blue:196.0/255.0 alpha:1.0];
        [self addSubview:_blueView];
        
    }
    return self;
}

- (void)layoutSubviews {
    CGRect bounds = self.bounds;
    _navigationView.frame = CGRectMake(0, 0, KSCWidth, KKNavBarHeight);
    CGFloat roomTextWidth = 350;
    CGFloat roomTextHeight = [_roomText sizeThatFits:bounds.size].height;
    CGFloat roomTextTop = (CGRectGetMaxY(self.bounds) - roomTextHeight)/2.5;
    _roomText.frame = CGRectMake((KSCWidth - 350)/2, roomTextTop, roomTextWidth,
    roomTextHeight);
    _blueView.frame = CGRectMake((KSCWidth - 350)/2,
    roomTextTop+roomTextHeight,
    roomTextWidth,
    1.5);
    CGFloat regularCallFrameTop = CGRectGetMaxY(_roomText.frame) + kRoomTextFieldHeight;
    CGRect regularCallFrame = CGRectMake((KSCWidth - 200)/2,
                                         regularCallFrameTop,
                                         200,
                                         45);
    
    _startRegularCallButton.frame = regularCallFrame;
    
    
}

- (void)onStartRegularCall:(id)sender {
    [_delegate mainView:self didInputPhoneId:_roomText.roomText];
}


@end
