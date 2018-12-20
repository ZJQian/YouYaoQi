//
//  FindADTableViewCell.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/5.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "FindADTableViewCell.h"

@interface FindADTableViewCell ()


@property (nonatomic, strong) UIImageView      *           img_cover;

@end

@implementation FindADTableViewCell


- (void)setSubViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.img_cover];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.img_cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}




- (void)setModel:(FindComicModel *)model {
    _model = model;
    [self.img_cover sd_setImageWithURL:[NSURL URLWithString:model.comics[0].cover] placeholderImage:[UIImage imageNamed:@"boutique_header_placeholder_414x193_"]];
    
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
        img;
    }));
}


@end
