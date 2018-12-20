//
//  ADModel.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/14.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BannerItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADModel : NSObject

@property (nonatomic, copy) NSString         *           image_id;
@property (nonatomic, assign) BOOL                       is_cache;
@property (nonatomic, copy) NSString         *           image_url;
@property (nonatomic, copy) NSString         *           receive_time;
@property (nonatomic, copy) NSString         *           show_time;
@property (nonatomic, copy) NSString         *           image_width;
@property (nonatomic, copy) NSString         *           image_height;
@property (nonatomic, assign) NSInteger                  linkType;
@property (nonatomic, copy) NSArray <ExtModel *>         *           ext;



@end

NS_ASSUME_NONNULL_END
