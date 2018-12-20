//
//  RankTableViewCell.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/7.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "RankModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RankTableViewCell : BaseTableViewCell


@property (nonatomic, strong) RankComicModel         *           model;
@property (nonatomic, strong) UILabel        *           lb_rank;
@property (nonatomic, strong) UIImageView        *           img_rank;


@end

NS_ASSUME_NONNULL_END
