//
//  NSString+YExt.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/3.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YExt)



/**
 *  md5 hash, 返回小写字符串.
 */
- (nullable NSString *)md5String;


/**
 是否不为空
 */
- (BOOL)isNotBlank;



@end

NS_ASSUME_NONNULL_END
