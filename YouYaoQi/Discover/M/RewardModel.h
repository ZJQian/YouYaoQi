//
//  RewardModel.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/6.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RewardModel : NSObject


@property (nonatomic, copy) NSString         *           comicId;
@property (nonatomic, copy) NSString         *           giftName;
@property (nonatomic, copy) NSString         *           nickname;
@property (nonatomic, copy) NSString         *           comicName;
@property (nonatomic, copy) NSString         *           cover;
@property (nonatomic, assign) BOOL                       isVipUser;
@property (nonatomic, assign) NSInteger                  giftCount;


@end

NS_ASSUME_NONNULL_END
