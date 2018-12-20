//
//  GlobalUtil.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/20.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "GlobalUtil.h"

@implementation GlobalUtil

+ (NSString *)getSkinFolderPath {
    
    NSDictionary *skinDic = (NSDictionary *)[DefaultsUtil getSkin];
    NSArray *pathes = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *path_Caches = [pathes objectAtIndex:0];//大文件放在沙盒下的Library/Caches
    NSString *path = [path_Caches stringByAppendingString:skinDic[@"addPath"]];
    return path;
}


+ (NSDictionary *)getSkinConfigFile {
    
    NSDictionary *skinDic = (NSDictionary *)[DefaultsUtil getSkin];
    NSDictionary *dic = skinDic[@"packageDic"];
    return dic;
}


@end
