//
//  NSString+YExt.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/3.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "NSString+YExt.h"
#import "NSData+YExt.h"

@implementation NSString (YExt)


- (NSString *)md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5String];
}


- (BOOL)isNotBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}



@end
