//
//  NSData+YExt.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/3.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (YExt)


/**
 * md5 hash, 返回小写字符串。
 */
- (NSString *)md5String;

/**
 * md5 hash, 返回NSData。
 */
- (NSData *)md5Data;



@end

NS_ASSUME_NONNULL_END
