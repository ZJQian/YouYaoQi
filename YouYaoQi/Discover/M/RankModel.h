//
//  RankModel.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/7.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RankModel : NSObject

@end

@interface RankComicModel : NSObject

@property (nonatomic, copy) NSString         *           cover;
@property (nonatomic, copy) NSString         *           name;
@property (nonatomic, copy) NSString         *           comic_id;
@property (nonatomic, copy) NSString         *           comic_description;
@property (nonatomic, copy) NSString         *           author;
@property (nonatomic, copy) NSString         *           short_description;
@property (nonatomic, copy) NSArray          *           tags;


@end

@class RankOptionModel;
@interface RankTabModel : NSObject

@property (nonatomic, copy) NSString         *           title;
@property (nonatomic, assign) NSInteger                  val;
@property (nonatomic, copy) NSArray<RankOptionModel *>          *           rankOptionList;
@property (nonatomic, copy) NSString         *           defaultValue;

@end

@interface RankOptionModel : NSObject

@property (nonatomic, copy) NSString         *           name;
@property (nonatomic, copy) NSString         *           argVal;

@end

NS_ASSUME_NONNULL_END
