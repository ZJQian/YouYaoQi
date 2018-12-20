//
//  FindFourItemTableViewCell.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/5.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BannerItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FindFourItemTableViewCell : BaseTableViewCell


@property (nonatomic, strong) FindComicModel         *           model;


@end


@interface ItemCell : UICollectionViewCell


@property (nonatomic, strong) FindComicItemModel         *           model;

@end

NS_ASSUME_NONNULL_END
