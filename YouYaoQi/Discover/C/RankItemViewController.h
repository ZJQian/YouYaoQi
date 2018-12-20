//
//  RankItemViewController.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/7.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "CBaseTableViewController.h"
#import "RankModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RankItemViewController : CBaseTableViewController


@property (nonatomic, assign) NSInteger                     index;
@property (nonatomic, strong) NSMutableArray         *      defaultRankArray;
@property (nonatomic, strong) RankTabModel           *      rankTabModel;


@end

NS_ASSUME_NONNULL_END
