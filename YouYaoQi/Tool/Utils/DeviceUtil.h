//
//  DeviceUtil.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/3.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceUtil : NSObject


/**
 获取系统版本
 */
+ (NSString *)systemVersion;



/**
 app版本号
 */
+ (NSString *)appVersion;



/**
 获取手机型号
 */
+ (NSString*)deviceModelName;

@end

NS_ASSUME_NONNULL_END
