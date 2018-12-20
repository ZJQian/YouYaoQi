//
//  SkinTableViewCell.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/4.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "SkinTableViewCell.h"
#import "UIImage+YExt.h"

@interface SkinTableViewCell ()


@property (nonatomic, strong) UIImageView      *           img_cover;
@property (nonatomic, strong) UILabel          *           lb_title;
@property (nonatomic, strong) UILabel          *           lb_price;
@property (nonatomic, strong) UIButton         *           btn_action;

@end

@implementation SkinTableViewCell


- (void)setFrame:(CGRect)frame {
    frame.origin.x = 12;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 15;
    frame.origin.y += 10;
    [super setFrame:frame];
}

-(void)setSubViews {
    
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView sd_addSubviews:@[self.img_cover,
                                       self.lb_title,
                                       self.lb_price,
                                       self.btn_action]];

    [self setConerRadius:7];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.img_cover.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthEqualToHeight();
    
    self.lb_title.sd_layout
    .leftSpaceToView(self.img_cover, 30)
    .topSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    
    self.lb_price.sd_layout
    .leftEqualToView(self.lb_title)
    .topSpaceToView(self.lb_title, 8)
    .rightEqualToView(self.lb_title)
    .autoHeightRatio(0);
    
    self.btn_action.sd_layout
    .leftEqualToView(self.lb_title)
    .bottomSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 30)
    .heightIs(35);
}

- (void)setModel:(SkinModel *)model {
    if ([model.cover isEqualToString:@"theme_default_184x184_"]) {
        
        self.img_cover.image = [UIImage imageNamed:model.cover];
    }else{
        [self.img_cover sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@""]];
    }
    self.lb_title.text = model.skinName;
    if (model.skinType == 1) {
        UIImage *img = [UIImage imageNamed:@"actionNotice_110x40_"];
        [self.btn_action setBackgroundImage:[UIImage y_stretchLeftAndRightWithContainerSize:CGSizeMake(self.contentView.width-self.contentView.height-60, img.size.height) image:img] forState:UIControlStateNormal];
        [self.btn_action setTitle:@"立即使用" forState:UIControlStateNormal];
        self.lb_price.text = @"免费";
    }else if (model.skinType == 2) {
        UIImage *img = [UIImage imageNamed:@"orderNotice_110x40_"];
        [self.btn_action setBackgroundImage:[UIImage y_stretchLeftAndRightWithContainerSize:CGSizeMake(self.contentView.width-self.contentView.height-60, img.size.height) image:img] forState:UIControlStateNormal];
        [self.btn_action setTitle:@"立即购买" forState:UIControlStateNormal];
        self.lb_price.text = [NSString stringWithFormat:@"%ld妖气币\n会员%ld妖气币",(long)model.skinOriginPrice,(long)model.skinRealPrice];
    }else if (model.skinType == 3) {
        UIImage *img = [UIImage imageNamed:@"vipNotice_110x40_"];
        [self.btn_action setBackgroundImage:[UIImage y_stretchLeftAndRightWithContainerSize:CGSizeMake(self.contentView.width-self.contentView.height-60, img.size.height) image:img] forState:UIControlStateNormal];
        [self.btn_action setTitle:@"开通会员" forState:UIControlStateNormal];
        self.lb_price.text = @"会员专属";
    }
}

- (void)btnAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickWithCell:)]) {
        [self.delegate clickWithCell:self];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - lazy

- (UIImageView *)img_cover {
    return C_LAZY(_img_cover, ({
        UIImageView *img = [UIImageView new];
        img;
    }));
}

- (UILabel *)lb_title {
    return C_LAZY(_lb_title, ({
        UILabel *lb = [UILabel new];
        lb.font = [UIFont boldSystemFontOfSize:14];
        lb;
    }));
}

- (UILabel *)lb_price {
    return C_LAZY(_lb_price, ({
        UILabel *lb = [UILabel new];
        lb.font = [UIFont boldSystemFontOfSize:12];
        lb.textColor = [UIColor lightGrayColor];
        lb.numberOfLines = 0;
        lb;
    }));
}


- (UIButton *)btn_action {
    return C_LAZY(_btn_action, ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = Y_Font(14);
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    }));
}

@end
