//
//  DefaultsUtil.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/13.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DefaultsUtil : NSObject


+ (id)getValueWithKey:(NSString *)key;


/**
 第一次打开 APP
 */
+ (void)saveFirstIn;

+ (BOOL)isFirstIn;



/**
 广告页
 */
+ (NSString *)getAdvertise;
+ (void)setAdvertise:(NSString *)adImage;



/**
 保存皮肤
 */
+ (void)saveSkin:(id)skin;
+ (id)getSkin;
+ (void)removeSkin;

@end

NS_ASSUME_NONNULL_END
