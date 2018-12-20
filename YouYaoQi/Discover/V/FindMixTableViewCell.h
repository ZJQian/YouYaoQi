//
//  FindMixTableViewCell.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/5.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BannerItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FindMixTableViewCell : BaseTableViewCell


@property (nonatomic, strong) FindComicModel         *           model;



@end


@interface MixItemCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView     *        img_cover;
@property (nonatomic, strong) UILabel     *        lb_title;
@property (nonatomic, strong) UILabel     *        lb_description;
@property (nonatomic, strong) FindComicItemModel         *           model;

@end




NS_ASSUME_NONNULL_END
