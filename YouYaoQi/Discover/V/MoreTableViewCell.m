//
//  MoreTableViewCell.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/10.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "MoreTableViewCell.h"

@interface MoreTableViewCell ()

@property (nonatomic, strong) UIImageView     *       img_cover;
@property (nonatomic, strong) UILabel         *       lb_title;
@property (nonatomic, strong) UILabel         *       lb_author;
@property (nonatomic, strong) UILabel         *       lb_description;


@end

@implementation MoreTableViewCell


- (void)setSubViews {
    
    [self.contentView addSubview:self.img_cover];
    [self.contentView addSubview:self.lb_title];
    [self.contentView addSubview:self.lb_author];
    [self.contentView addSubview:self.lb_description];

    self.img_cover.sd_layout
    .leftSpaceToView(self.contentView, 12)
    .topSpaceToView(self.contentView, 8)
    .widthIs(SCREEN_WIDTH/3)
    .autoHeightRatio(639.0/484.0);
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(SCREEN_WIDTH/3+12+12));
        make.top.equalTo(@20);
    }];
    
    [self.lb_author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_title);
        make.centerY.equalTo(self.contentView).offset(-35);
        make.right.equalTo(@(-30));
    }];
    
    [self.lb_description mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lb_title);
        make.top.equalTo(self.lb_author.mas_bottom).offset(10);
        make.right.equalTo(self.lb_author);
    }];
}


- (void)setModel:(MoreModel *)model {
    _model = model;
    [self.img_cover sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"today_special_placeholder_374x460_"]];
    self.lb_title.text = model.name;
    self.lb_author.text = model.author;
    self.lb_description.text = model.more_description;
    
    [self setupAutoHeightWithBottomView:self.img_cover bottomMargin:8];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)img_cover {
    return C_LAZY(_img_cover, ({
        UIImageView *img = [UIImageView new];
        [img setConerRadius:6];
        img;
    }));
}

- (UILabel *)lb_title {
    return C_LAZY(_lb_title, ({
        UILabel *lb = [UILabel new];
        lb.font = B_Font(16);
        lb;
    }));
}

- (UILabel *)lb_author {
    return C_LAZY(_lb_author, ({
        UILabel *lb = [UILabel new];
        lb.font = Y_Font(12);
        lb.textColor = [UIColor lightGrayColor];
        lb;
    }));
}

- (UILabel *)lb_description {
    return C_LAZY(_lb_description, ({
        UILabel *lb = [UILabel new];
        lb.font = Y_Font(12);
        lb.textColor = [UIColor lightGrayColor];
        lb.numberOfLines = 3;
        lb;
    }));
}

@end
