//
//  NavBarView.h
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/7.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NavBarView : UIView


@property (nonatomic, strong) UIButton         *           btn_left;
@property (nonatomic, strong) UILabel          *           lb_left;
@property (nonatomic, strong) UIImageView      *           leftImgView;
@property (nonatomic, strong) UIImage          *           img_left;
@property (nonatomic, strong) UIImage          *           img_right;

@property (nonatomic, strong) UIButton         *           btn_right;
@property (nonatomic, strong) UILabel          *           lb_navTitle;
@property (nonatomic, strong) UIImageView      *           img_bg;


@end

NS_ASSUME_NONNULL_END
