//
//  APIConst.h
//  OC_Cloud
//
//  Created by ZJQian on 2018/11/28.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIConst : NSObject


/********** 网络请求地址 ***********/

// 服务地址
FOUNDATION_EXTERN NSString *const CURL;
FOUNDATION_EXTERN NSString *const CURL_Test;


///首都网警
FOUNDATION_EXTERN NSString *const police;


///启动广告
FOUNDATION_EXTERN NSString *const launcher;

/// 今日更新
FOUNDATION_EXTERN NSString *const todayUpdate;


/// 皮肤
FOUNDATION_EXTERN NSString *const skinList;

///发现
FOUNDATION_EXTERN NSString *const detectList;

///打赏礼物
FOUNDATION_EXTERN NSString *const giftList;

///排行榜
FOUNDATION_EXTERN NSString *const rankComicList;

///vip
FOUNDATION_EXTERN NSString *const vipList;

///订阅
FOUNDATION_EXTERN NSString *const newSubscribeList;

///更多
FOUNDATION_EXTERN NSString *const commonComicList;



///搜索热词
FOUNDATION_EXTERN NSString *const hotkeywordsnew;


@end

NS_ASSUME_NONNULL_END

