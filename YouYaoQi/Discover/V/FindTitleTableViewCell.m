//
//  FindTitleTableViewCell.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/5.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "FindTitleTableViewCell.h"


@interface FindTitleTableViewCell ()

@property (nonatomic, strong) UILabel         *         lb_title;

@end

@implementation FindTitleTableViewCell



- (void)setSubViews {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.img_bg];
    [self.contentView addSubview:self.lb_title];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    [self.img_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}


- (void)setModel:(FindComicModel *)model {
    _model = model;
    self.lb_title.text = model.itemTitle;
    
    [self setupAutoHeightWithBottomView:self.lb_title bottomMargin:20];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (UILabel *)lb_title {
    return C_LAZY(_lb_title, ({
        UILabel *lb = [UILabel new];
        lb.font = B_Font(15);
        lb.textAlignment = NSTextAlignmentCenter;
        lb;
    }));
}

- (UIImageView *)img_bg {
    return C_LAZY(_img_bg, ({
        UIImageView *img = [UIImageView new];
        img;
    }));
}

@end
