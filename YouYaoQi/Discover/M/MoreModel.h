//
//  MoreModel.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/10.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoreModel : NSObject

@property (nonatomic, copy) NSString         *           cover;
@property (nonatomic, copy) NSString         *           name;
@property (nonatomic, copy) NSString         *           comicId;
@property (nonatomic, copy) NSString         *           more_description;
@property (nonatomic, copy) NSString         *           author;
@property (nonatomic, copy) NSString         *           last_update_time;
@property (nonatomic, copy) NSString         *           last_update_chapter_name;
@property (nonatomic, copy) NSArray          *           tags;



@end

NS_ASSUME_NONNULL_END
