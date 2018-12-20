//
//  SkinModel.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/4.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "SkinModel.h"

@implementation SkinModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"skin_description":@"description",
             @"ID":@"id"
             };
}

@end
