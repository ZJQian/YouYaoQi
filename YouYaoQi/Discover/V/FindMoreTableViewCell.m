//
//  FindMoreTableViewCell.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/5.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "FindMoreTableViewCell.h"


@interface FindMoreTableViewCell ()

@property (nonatomic, strong) UIButton    *         btn_more;
@property (nonatomic, strong) UIButton    *         btn_change;


@end

@implementation FindMoreTableViewCell

- (void)setSubViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.btn_more];
    [self.contentView addSubview:self.btn_change];
}

- (void)setModel:(FindComicModel *)model {
    _model = model;
    
    if (model.canMore && model.canChange) {
        CGFloat w = (SCREEN_WIDTH-45)/2;
        CGFloat h = 28;
        [self.btn_more setHidden:NO];
        [self.btn_change setHidden:NO];

        [self.btn_more mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(@15);
            make.width.equalTo(@(w));
            make.height.equalTo(@(h));
        }];
        
        [self.btn_change mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(@(-15));
            make.width.equalTo(@(w));
            make.height.equalTo(@(h));
        }];
    }else if (model.canMore && !model.canChange) {
        CGFloat w = (SCREEN_WIDTH-30);
        CGFloat h = 28;
        [self.btn_change setHidden:YES];
        [self.btn_more setHidden:NO];

        [self.btn_more mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(@15);
            make.width.equalTo(@(w));
            make.height.equalTo(@(h));
        }];
    }else if (model.canMore && model.canChange) {
        CGFloat w = (SCREEN_WIDTH-30);
        CGFloat h = 28;
        [self.btn_more setHidden:YES];
        [self.btn_change setHidden:NO];
        [self.btn_change mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(@15);
            make.width.equalTo(@(w));
            make.height.equalTo(@(h));
        }];
    }else {
        [self.btn_more setHidden:YES];
        [self.btn_change setHidden:YES];
        
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

#pragma mark - action

- (void)moreAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(moreWithCell:)]) {
        [self.delegate moreWithCell:self];
    }
}

- (void)changeAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeWithCell:)]) {
        [self.delegate changeWithCell:self];
    }
}

#pragma mark - lazy

- (UIButton *)btn_more {
    return C_LAZY(_btn_more, ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"boutique_item_showNewMore_10x10_"] forState:UIControlStateNormal];
        [btn setTitle:@"更多" forState:UIControlStateNormal];
        [btn setTitleColor:[[UIColor grayColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
        btn.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
        [btn setConerRadius:14];
        btn.titleLabel.font = Y_Font(12);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0,30, 0, -30);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        [btn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        btn;
    }));
}

- (UIButton *)btn_change {
    return C_LAZY(_btn_change, ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"boutique_item_showChange_10x10_"] forState:UIControlStateNormal];
        [btn setTitle:@"换一换" forState:UIControlStateNormal];
        [btn setTitleColor:[[UIColor grayColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
        btn.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
        btn.titleLabel.font = Y_Font(12);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0,45, 0, -45);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        [btn setConerRadius:14];
        [btn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        btn;
    }));
}


@end
