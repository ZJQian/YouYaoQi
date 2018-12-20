//
//  FindMoreTableViewCell.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/5.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BannerItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FindMoreTableViewCell;
@protocol FindMoreTableViewCellDelegate <NSObject>

- (void)moreWithCell:(FindMoreTableViewCell *)cell;
- (void)changeWithCell:(FindMoreTableViewCell *)cell;

@end

@interface FindMoreTableViewCell : BaseTableViewCell



@property (nonatomic, strong) FindComicModel         *           model;
@property (nonatomic, weak) id<FindMoreTableViewCellDelegate>                     delegate;

@end

NS_ASSUME_NONNULL_END
