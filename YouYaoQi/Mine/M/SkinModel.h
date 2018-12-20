//
//  SkinModel.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/4.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SkinModel : NSObject


@property (nonatomic, copy) NSString         *           address;
@property (nonatomic, copy) NSString         *           cover;
@property (nonatomic, copy) NSString         *           skin_description;
@property (nonatomic, assign) NSInteger                  discountType;
@property (nonatomic, copy) NSString         *           ID;
@property (nonatomic, copy) NSString         *           layoutVersion;
@property (nonatomic, copy) NSString         *           name;
@property (nonatomic, copy) NSString         *           packageName;
@property (nonatomic, copy) NSString         *           size;
@property (nonatomic, copy) NSString         *           skinApkMd5;
@property (nonatomic, copy) NSString         *           skinName;
@property (nonatomic, assign) NSInteger                  skinOriginPrice;
@property (nonatomic, assign) NSInteger                  skinRealPrice;
@property (nonatomic, assign) NSInteger                  skinState;
@property (nonatomic, assign) NSInteger                  skinTag;
@property (nonatomic, assign) NSInteger                  skinType;
@property (nonatomic, copy) NSString         *           uniqueId;
@property (nonatomic, copy) NSString         *           versionCode;
@property (nonatomic, copy) NSString         *           versionName;


@end

NS_ASSUME_NONNULL_END
