//
//  CServerConfig.m
//  OC_Cloud
//
//  Created by ZJQian on 2018/11/28.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "CServerConfig.h"
#import "APIConst.h"

static NSString *ConfigEnv;  //环境参数 00: 测试环境,01: 生产环境

@implementation CServerConfig


+(void)setConfigEnv:(NSString *)value
{
    ConfigEnv = value;
}

+(NSString *)ConfigEnv
{
    return ConfigEnv;
}
//获取服务器地址
+ (NSString *)getServerAddr{
    if ([ConfigEnv isEqualToString:@"00"]) {
        return CURL_Test;
    }else{
        return CURL;
    }
}

@end
