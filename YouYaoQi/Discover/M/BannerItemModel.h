//
//  BannerItemModel.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/5.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ExtModel;
NS_ASSUME_NONNULL_BEGIN

@interface BannerItemModel : NSObject


@property (nonatomic, assign) NSInteger                  linkType;
@property (nonatomic, copy) NSString         *           cover;
@property (nonatomic, copy) NSString         *           ID;
@property (nonatomic, copy) NSString         *           title;
@property (nonatomic, copy) NSString         *           content;
@property (nonatomic, copy) NSArray<ExtModel *>          *           ext;

@end

@interface ExtModel : NSObject


@property (nonatomic, copy) NSString         *           key;
@property (nonatomic, copy) NSString         *           val;


@end

@class FindComicItemModel;
@interface FindComicModel : NSObject

@property (nonatomic, copy) NSString         *           titleIconUrl;
@property (nonatomic, copy) NSString         *           fresh_TitleIconUrl;
@property (nonatomic, copy) NSString         *           itemTitle;
@property (nonatomic, copy) NSString         *           comic_description;
@property (nonatomic, copy) NSString         *           sortId;
@property (nonatomic, copy) NSString         *           argName;
@property (nonatomic, copy) NSString         *           argValue;
@property (nonatomic, copy) NSArray<FindComicItemModel *>         *           comics;
@property (nonatomic, assign) NSInteger                    comicType;
@property (nonatomic, assign) NSInteger                    nextPage;
@property (nonatomic, assign) BOOL                    canChange;
@property (nonatomic, assign) BOOL                    canMore;


@end


@interface FindComicItemModel : NSObject

@property (nonatomic, copy) NSString         *           comicId;
@property (nonatomic, copy) NSString         *           name;
@property (nonatomic, copy) NSString         *           cover;
@property (nonatomic, copy) NSArray          *           tags;
@property (nonatomic, copy) NSString         *           short_description;


@end

NS_ASSUME_NONNULL_END
