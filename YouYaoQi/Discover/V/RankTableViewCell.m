//
//  RankTableViewCell.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/7.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "RankTableViewCell.h"

@interface RankTableViewCell ()

@property (nonatomic, strong) UIImageView        *           img_cover;
@property (nonatomic, strong) UILabel        *           lb_title;
@property (nonatomic, strong) UILabel        *           lb_description;
@property (nonatomic, strong) UILabel        *           lb_tag;

@end

@implementation RankTableViewCell

- (void)setSubViews {
    [self.contentView addSubview:self.img_cover];
    [self.contentView addSubview:self.lb_title];
    [self.contentView addSubview:self.lb_description];
    [self.contentView addSubview:self.lb_tag];
    [self.contentView addSubview:self.img_rank];
    [self.contentView addSubview:self.lb_rank];

    
    self.img_cover.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 10)
    .heightIs(120)
    .autoWidthRatio(484.0/639.0);
    
    self.lb_title.sd_layout
    .leftSpaceToView(self.img_cover, 15)
    .topSpaceToView(self.contentView, 20)
    .heightIs(15)
    .rightSpaceToView(self.contentView, 40);
    
    self.lb_description.sd_layout
    .leftEqualToView(self.lb_title)
    .rightEqualToView(self.lb_title)
    .topSpaceToView(self.lb_title, 10)
    .heightIs(12);
    
    self.lb_tag.sd_layout
    .leftEqualToView(self.lb_title)
    .rightEqualToView(self.lb_title)
    .bottomEqualToView(self.img_cover).offset(-10)
    .heightIs(12);
    
    
    [self.img_rank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView).offset(SCREEN_WIDTH/2-30);
    }];
    [self.lb_rank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView).offset(SCREEN_WIDTH/2-30);
    }];
}



- (void)setModel:(RankComicModel *)model {
    _model = model;
    
    [self.img_cover sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"boutique_placeholder_139x176_"]];
    self.lb_title.text = model.name;
    self.lb_description.text = model.short_description;
    self.lb_tag.text = [model.tags componentsJoinedByString:@" "];
    
    [self setupAutoHeightWithBottomView:self.img_cover bottomMargin:10];

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

- (UIImageView *)img_rank {
    return C_LAZY(_img_rank, ({
        UIImageView *img = [UIImageView new];
        img;
    }));
}

- (UILabel *)lb_title {
    return C_LAZY(_lb_title, ({
        UILabel *lb = [UILabel new];
        lb.font = Y_Font(14);
        lb;
    }));
}

- (UILabel *)lb_description {
    return C_LAZY(_lb_description, ({
        UILabel *lb = [UILabel new];
        lb.font = Y_Font(11);
        lb.textColor = [UIColor lightGrayColor];
        lb;
    }));
}

- (UILabel *)lb_tag {
    return C_LAZY(_lb_tag, ({
        UILabel *lb = [UILabel new];
        lb.font = Y_Font(11);
        lb.textColor = [UIColor lightGrayColor];
        lb;
    }));
}

- (UILabel *)lb_rank {
    return C_LAZY(_lb_rank, ({
        UILabel *lb = [UILabel new];
        lb.font = B_Font(20);
        lb.textColor = [UIColor lightGrayColor];
        lb.textAlignment = NSTextAlignmentCenter;
        lb;
    }));
}

@end
