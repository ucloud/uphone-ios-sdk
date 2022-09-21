//
//  UPhoneBaseView.m
//  AppRTCMobile-iOS
//
//  Created by user on 2021/10/25.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import "UPhoneBaseView.h"

@implementation UPhoneBaseView

+ (instancetype)loadViewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}


@end
