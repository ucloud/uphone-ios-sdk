//
//  UCCommon.h
//  AppRTCMobile-iOS
//
//  Created by user on 2021/10/29.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#ifndef UCCommon_h
#define UCCommon_h

#define  IS_iPhoneX (((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && (([UIScreen mainScreen].bounds.size.width>=812.0)||([UIScreen mainScreen].bounds.size.height>=812.0))) ? YES : NO)
#define KKNavBarHeight (IS_iPhoneX ? 88 : 64)
#define KKNavBarHeight2 (IS_iPhoneX ? 38 : 0)

#define  KSCWidth [[UIScreen mainScreen] bounds].size.width
#define  KSCHeight [[UIScreen mainScreen] bounds].size.height

#define HAND_WIDTH self.frame.size.width
#define HAND_HEIGHT self.frame.size.height

#define iphoneX_h 812.0f
#define iphoneX_w 375.0f
#define distance_bottom (KSCHeight >= iphoneX_h ? 34.0f : 0.0f)

#define UIColorFromRGB(rgbValue,A) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0    \
blue:((float)(rgbValue & 0xFF)) / 255.0             \
alpha:(A)]
#define RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#endif /* UCCommon_h */
