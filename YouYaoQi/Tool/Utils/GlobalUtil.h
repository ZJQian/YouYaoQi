//
//  GlobalUtil.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/20.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalUtil : NSObject



/**
 获取存储皮肤数据的文件夹路径
 */
+ (NSString *)getSkinFolderPath;



/**
 获取皮肤配置json文件数据
 */
+ (NSDictionary *)getSkinConfigFile;


@end

NS_ASSUME_NONNULL_END
