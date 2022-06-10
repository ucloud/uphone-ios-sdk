//
//  UPhoneTouchButton.h
//  AppRTCMobile-iOS
//
//  Created by user on 2021/10/22.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UPhoneTouchButton : UIButton
{
    BOOL MoveEnable;
    BOOL MoveEnabled;
    CGPoint beginpoint;
}

@property(nonatomic)BOOL MoveEnable;
@property(nonatomic)BOOL MoveEnabled;
@end

NS_ASSUME_NONNULL_END
