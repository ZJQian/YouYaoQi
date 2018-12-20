//
//  RankModel.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/7.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "RankModel.h"

@implementation RankModel

@end

@implementation RankComicModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"comic_description":@"description"};
}

@end

@implementation RankTabModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"rankOptionList":@"RankOptionModel"};
}


@end

@implementation RankOptionModel

@end
