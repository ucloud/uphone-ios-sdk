/*
 *  Copyright 2015 The WebRTC Project Authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#import <UIKit/UIKit.h>

@class UPhoneMainView;

@protocol UPhoneMainViewDelegate <NSObject>
- (void)mainView:(UPhoneMainView *)mainView didInputPhoneId:(NSString *)phoneId;

@end

// The main view of AppRTCMobile. It contains an input field for entering a room
// name on apprtc to connect to.
@interface UPhoneMainView : UIView
@property(nonatomic, weak) id<UPhoneMainViewDelegate> delegate;


@end
