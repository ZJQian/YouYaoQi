//
//  BannerItemModel.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/5.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "BannerItemModel.h"

@implementation BannerItemModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}


+ (NSDictionary *)mj_objectClassInArray {
    return @{@"ext":@"ExtModel"};
}

@end

@implementation ExtModel

@end

@implementation FindComicModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"comic_description":@"description",
             @"fresh_TitleIconUrl":@"newTitleIconUrl"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"comics":@"FindComicItemModel"};
}

@end

@implementation FindComicItemModel

@end
