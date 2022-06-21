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

@class UPhoneVideoViewController;
@protocol UPhoneVideoViewControllerDelegate <NSObject>
/**
 功能描述：断开连接云手机时需要实现的功能可以写在这里
 */
- (void)viewControllerDidFinish:(UPhoneVideoViewController *)viewController;

@end

@interface UPhoneVideoViewController : UIViewController

/**
 token 连接访问校验值(注:如果调用api接口SetUPhoneToken进行了设置，此处为必填,否则填空)
 */
@property(nonatomic, copy)NSString *token;
@property(nonatomic, weak) id<UPhoneVideoViewControllerDelegate> delegate;

/**
 功能描述：初始化云手机
 参数说明：
 uphoneId接入商的唯一 ID，用来区分不同的接入商。
 */

- (instancetype)initWithUphone:(NSString *)uphoneId;

/**
 功能描述:连接云手机
 */
- (void)connectUPhone;

/**
 功能描述:断开连接云手机
 */
- (void)disConnectUPhone;


/**
 功能描述:设置 UPhone 分辨率
 参数描述:resolution，
 取值如下整数:
 0// 标清
 3// 高清
 6// 超清
 */
- (void)setUPhoneResolution:(int)resolution;

/**
 功能描述: 获得网络延时
 返回参数: NSString 类型参数
 */
- (NSInteger)getUPhoneLinkDelay;

/**
 功能描述: 返回清理后台
 */
- (void)backUPhoneTaskList;

/**
 功能描述: 返回桌面
 */
- (void)backUPhoneHome;

/**
 功能描述: 返回上一级
 */
- (void)backUPhoneLastPage;

/**
 功能描述:开始直播
 参数描述:url，直播推流地址
 */
- (void)startLiving:(NSString *)url;

/**
 功能描述:停止直播
 */
- (void)stopLiving;

/**
 功能描述:获取当前播放器截屏
 返回参数: UIImage 类型参数
 */
- (UIImage *)getShortcut;

/**
 功能描述:检测当前截屏是否黑屏
 参数描述:image，当前需要检测的UIImage对象
 返回参数：
 1//检测结果为纯色，排除黑色和全透明色，因为播放器没开始工作，不通设备获取截屏有的是纯黑色有的是纯透明色
 2//检测结果为纯透明色
 3//检测结果为正常
 4//检测结果为纯黑色
 */
- (NSInteger)checkBlackScreen:(UIImage *)image;


/**
 功能描述: 获取网络传输过程中的丢包率
 返回参数: NSString类型参数，已转化成百分比并且保留两位小数，例如：0.15%。
 */
- (NSString *)getLossRate;

/**
 功能描述: 获取视频流基本参数
 返回参数:NSDictionary 类型参数
 key值为style，value返回值为0时表示横屏，value为1时表示竖屏；
 key值为height，value返回值即为当前分辨率的height；
 key值为width，value返回值即为当前分辨率的width。
 */
- (NSDictionary *)getQRCodeData;

/**
 功能描述: 判断是否支持直播
 返回参数：NSString 类型参数
 0//未设置
 1//正在启动推流
 2//正在推流
 3//已停止推流
 */
- (NSString *)isSupportLiving;

/**
 功能描述: 判断是否支持静音
 参数描述 ：BOOL 类型参数
 YES：全局静音
 NO：取消全局静音
 */
- (void)setAudioMute:(BOOL)isMute;

/**
 功能描述: 获取网络速度
 返回参数: NSString类型参数，保留两位小数，例如：0.15MB/s。
 */
- (NSString *)getNetworkSpeed;


@end
