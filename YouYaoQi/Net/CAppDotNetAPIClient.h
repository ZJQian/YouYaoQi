//
//  CAppDotNetAPIClient.h
//  OC_Cloud
//
//  Created by ZJQian on 2018/11/28.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CAppDotNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

NS_ASSUME_NONNULL_END
