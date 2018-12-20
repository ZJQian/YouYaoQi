//
//  RewardCycleView.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/6.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RewardModel;

NS_ASSUME_NONNULL_BEGIN

@interface RewardCycleView : UIView


@property (nonatomic, strong) NSMutableArray         *           rewardArray;

@end


@interface RewardCell : UICollectionViewCell


@property (nonatomic, strong) RewardModel         *           model;

@end


NS_ASSUME_NONNULL_END
