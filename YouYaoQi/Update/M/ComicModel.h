//
//  ComicModel.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/3.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TagModel;
NS_ASSUME_NONNULL_BEGIN

@interface ComicModel : NSObject

@property (nonatomic, assign) NSInteger                     actionType;
@property (nonatomic, copy) NSString         *           author;
@property (nonatomic, copy) NSString         *           btnColor;
@property (nonatomic, copy) NSString         *           chapterId;
@property (nonatomic, assign) NSInteger                    chapterIndex;
@property (nonatomic, copy) NSString         *           comicId;
@property (nonatomic, copy) NSString         *           cover;
@property (nonatomic, copy) NSString         *           comic_description;
@property (nonatomic, copy) NSString         *           title;
@property (nonatomic, copy) NSString         *           todayId;
@property (nonatomic, assign) NSInteger                    uiType;
@property (nonatomic, strong) NSArray        <TagModel *>*           tagList;




@end

NS_ASSUME_NONNULL_END

@interface TagModel : NSObject

@property (nonatomic, copy) NSString         *           tagColor;
@property (nonatomic, copy) NSString         *           tagStr;


@end
