//
//  CAppDotNetAPIClient.m
//  OC_Cloud
//
//  Created by ZJQian on 2018/11/28.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "CAppDotNetAPIClient.h"

@implementation CAppDotNetAPIClient


+ (instancetype)sharedClient {
    static CAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CAppDotNetAPIClient alloc] init];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}


@end
