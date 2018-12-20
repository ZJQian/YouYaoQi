//
//  CServerConfig.h
//  OC_Cloud
//
//  Created by ZJQian on 2018/11/28.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CServerConfig : NSObject


// env: 环境参数 00: 测试环境 01: 生产环境
+ (void)setConfigEnv:(NSString *)value;

// 返回环境参数 00: 测试环境 01: 生产环境
+ (NSString *)ConfigEnv;

// 获取服务器地址
+ (NSString *)getServerAddr;


@end

NS_ASSUME_NONNULL_END
