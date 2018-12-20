//
//  NavBarView.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/7.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "NavBarView.h"


@interface NavBarView ()

@property (nonatomic, strong) UIImageView      *           rightImgView;



@end

@implementation NavBarView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUserInteractionEnabled:YES];
        
        UIImageView *bg_img = [UIImageView new];
        [self addSubview:bg_img];
        [bg_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        self.img_bg = bg_img;
        
        
        
        UIButton *btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_back setUserInteractionEnabled:YES];
        [self addSubview:btn_back];
        [btn_back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(IS_IPHONEX ? 44.0 : 20.0));
            make.height.equalTo(@40);
            make.width.equalTo(@60);
            make.left.equalTo(@10);
        }];
        self.btn_left = btn_back;
        
        
        UIImageView *img = [UIImageView new];
        img.image = [UIImage imageNamed:@"backGreen_42x42_"];
        [self.btn_left addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@30);
            make.centerY.left.equalTo(btn_back);
        }];
        self.leftImgView = img;
        
        
        UILabel *lb_lef = [UILabel new];
        lb_lef.textColor = Color_theme;
        [lb_lef sizeToFit];
        lb_lef.font = Y_Font(14);
        [self.btn_left addSubview:lb_lef];
        [lb_lef mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(img.mas_right);
            make.centerY.equalTo(img);
            make.right.equalTo(btn_back);
        }];
        self.lb_left = lb_lef;
        
        
        
        UILabel *lb = [UILabel new];
        lb.font = B_Font(17);
        [lb sizeToFit];
        lb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.centerY.equalTo(btn_back);
            make.centerX.equalTo(self);
        }];
        self.lb_navTitle = lb;
        
        UIButton *btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn_right];
        [btn_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.centerY.equalTo(btn_back);
            make.width.equalTo(@60);
            make.right.equalTo(@(-10));
        }];
        self.btn_right = btn_right;
        
        
        UIImageView *img2 = [[UIImageView alloc] init];
        [self.btn_right addSubview:img2];
        self.rightImgView = img2;
        
        
    }
    return self;
}


- (void)setImg_left:(UIImage *)img_left {
    _img_left = img_left;
    CGFloat w = img_left.size.width;
    CGFloat h = img_left.size.height;
    self.leftImgView.image = img_left;
    [self.leftImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.equalTo(self.btn_left);
        make.width.equalTo(@(20*w/h));
        make.height.equalTo(@(20));
    }];
}

- (void)setImg_right:(UIImage *)img_right {
    _img_right = img_right;
    CGFloat w = img_right.size.width;
    CGFloat h = img_right.size.height;
    self.rightImgView.image = img_right;
    [self.rightImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(self.btn_right);
        make.width.equalTo(@(w));
        make.height.equalTo(@(h));
    }];
}


@end
