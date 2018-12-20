//
//  ComicModel.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/3.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "ComicModel.h"

@implementation ComicModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"comic_description":@"description"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"tagList": @"TagModel"};
}


@end

@implementation TagModel



@end

