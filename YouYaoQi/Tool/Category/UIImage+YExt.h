//
//  UIImage+YExt.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/4.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YExt)


/**
 图片拉伸
 */
+ (UIImage *)y_stretchLeftAndRightWithContainerSize:(CGSize)imageViewSize image:(UIImage *)originImage;


/**
 裁剪图片

 @param image 原图片
 @param offset 裁剪起始点
 @param cropSize 裁剪大小
 */
+(UIImage *)cropImage:(UIImage *)image offSet:(CGPoint)offset cropSize:(CGSize)cropSize;



/**
 缩放图片

 @param image 原图片
 @param size 缩放目标尺寸
 @return 新图片
 */
+ (UIImage*)originImage:(UIImage *)image scaleToSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
