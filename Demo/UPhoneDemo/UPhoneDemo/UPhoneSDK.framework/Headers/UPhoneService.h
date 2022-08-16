//
//  UCloudGameService.h
//  UCloudGameSDK
//
//  Created by user on 2021/11/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UPhoneService : NSObject

/**
 功能描述:重连云手机
 */
+ (void)reconnetUPhone;

/**
 功能描述:获得 SDK 版本号AFNetworking
 返回值: NSString 类型参数
 */
+ (NSString *)getVersionCode;


/**
 功能描述:获取用户最后一次操作时间戳
 返回值: NSString 类型参数，单位为：ms
 */
+ (NSString *)getLastUserOperationTimestamp;

@end

NS_ASSUME_NONNULL_END
