//
//  UIView+YExt.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/3.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YExt)


/**
 *  修改x坐标
 */
@property (assign, nonatomic)CGFloat x;

/**
 *  修改y坐标
 */
@property (assign, nonatomic)CGFloat y;

/**
 *  修改宽度
 */
@property (assign, nonatomic)CGFloat width;

/**
 *  修改高度
 */
@property (assign, nonatomic)CGFloat height;

/**
 *  修改坐标
 */
@property (assign, nonatomic)CGPoint origin;

/**
 *  修改大小
 */
@property (assign, nonatomic)CGSize size;

/**
 *  中间的X
 */
@property (assign, nonatomic, readonly)CGFloat midX;

/**
 *  中间的Y
 */
@property (assign, nonatomic, readonly)CGFloat midY;

/**
 *  最大的X
 */
@property (assign, nonatomic, readonly)CGFloat maxX;

/**
 *  最大的Y
 */
@property (assign, nonatomic, readonly)CGFloat maxY;

/**
 *  中点的X
 */
@property (nonatomic, assign) CGFloat centerX;
/**
 *  中点的Y
 */
@property (nonatomic, assign) CGFloat centerY;


- (void)setConerRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
