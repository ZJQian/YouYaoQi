//
//  DefaultsUtil.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/13.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "DefaultsUtil.h"


#define advertiseImage      @"adImage"
#define firstIn             @"First_in"
#define skinType            @"skin_type"


@implementation DefaultsUtil


+ (void)saveWithKey:(NSString *)key value:(id)value {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:value forKey:key];
    [ud synchronize];
}

+ (id)getValueWithKey:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:key];
}

+ (void)removeValueForKey:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:key];
    [ud synchronize];
}

+ (void)saveFirstIn {
    [self saveWithKey:firstIn value:@"goMain"];
}


+ (BOOL)isFirstIn {
    
    return ![self getValueWithKey:firstIn] ? YES : NO;
}


+ (NSString *)getAdvertise {
    
    return [self getValueWithKey:advertiseImage];
}

+ (void)setAdvertise:(NSString *)adImage {
    
    [self saveWithKey:advertiseImage value:adImage];
}



+ (id)getSkin {
    return [self getValueWithKey:skinType];
}

+ (void)saveSkin:(id)skin {
    [self saveWithKey:skinType value:skin];
}

+ (void)removeSkin {
    [self removeValueForKey:skinType];
}

@end
