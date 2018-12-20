//
//  UIImage+YExt.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/4.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "UIImage+YExt.h"

@implementation UIImage (YExt)



+ (UIImage *)y_stretchLeftAndRightWithContainerSize:(CGSize)imageViewSize image:(UIImage *)originImage {
    
    CGSize imageSize = originImage.size;
    CGSize bgSize = CGSizeMake(imageViewSize.width, imageViewSize.height); //imageView的宽高取整，否则会出现横竖两条缝
    
    UIImage *image = [originImage stretchableImageWithLeftCapWidth:floorf(imageSize.width * 0.6) topCapHeight:imageSize.height];
    CGFloat tempWidth = (bgSize.width)/2 + (imageSize.width)/2;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake((NSInteger)tempWidth, (NSInteger)bgSize.height), NO, [UIScreen mainScreen].scale);
    
    [image drawInRect:CGRectMake(0, 0, (NSInteger)tempWidth, (NSInteger)bgSize.height)];
    
    UIImage *firstStrechImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *secondStrechImage = [firstStrechImage stretchableImageWithLeftCapWidth:floorf(imageSize.width * 0.4) topCapHeight:imageSize.height];
    
    return secondStrechImage;
}


+(UIImage *)cropImage:(UIImage *)image offSet:(CGPoint)offset cropSize:(CGSize)cropSize{
    
    CGImageRef sourceImageRef = [image CGImage];//将UIImage转换成CGImageRef
    
    CGRect rect = CGRectMake(offset.x, offset.y, cropSize.width, cropSize.height);
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);//按照给定的矩形区域进行剪裁
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    return newImage;
}


+ (UIImage*)originImage:(UIImage *)image scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

@end
