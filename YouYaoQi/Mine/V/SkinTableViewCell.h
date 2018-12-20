//
//  SkinTableViewCell.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/4.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SkinModel.h"

NS_ASSUME_NONNULL_BEGIN

@class SkinTableViewCell;
@protocol SkinTableViewCellDelegate <NSObject>

- (void)clickWithCell:(SkinTableViewCell *)skinCell;

@end

@interface SkinTableViewCell : BaseTableViewCell


@property (nonatomic, strong) SkinModel         *           model;
@property (nonatomic, weak) id<SkinTableViewCellDelegate>                     delegate;


@end

NS_ASSUME_NONNULL_END
