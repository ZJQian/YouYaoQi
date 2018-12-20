//
//  DateSegmentView.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/4.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DateSegmentViewDelegate <NSObject>

- (void)rollToIndex:(NSInteger)index;

@end

@interface DateSegmentView : UIView


@property (nonatomic, weak) id<DateSegmentViewDelegate>                 delegate;

- (void)scrollToIndex: (NSInteger)index;


@end

NS_ASSUME_NONNULL_END
