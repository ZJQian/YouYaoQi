//
//  UpdateItemCell.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/3.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "UpdateItemCell.h"

@interface UpdateItemCell ()

@property (nonatomic, strong) UIImageView     *     img_cover;
@property (nonatomic, strong) UILabel         *     lb_title;
@property (nonatomic, strong) UILabel         *     lb_tag;
@property (nonatomic, strong) UILabel         *     lb_description;
@property (nonatomic, strong) UILabel         *     lb_author;
@property (nonatomic, strong) UILabel         *     lb_all;

@end

@implementation UpdateItemCell


- (void)setSubViews {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView sd_addSubviews:@[self.img_cover,
                                       self.lb_title,
                                       self.lb_tag,
                                       self.lb_description,
                                       self.lb_author,
                                       self.lb_all]];
    
    self.img_cover.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .autoHeightRatio(296.0/504.0);
    
    self.lb_title.sd_layout
    .leftSpaceToView(self.contentView, 12)
    .topSpaceToView(self.img_cover, 10).heightIs(25);
    [self.lb_title setSingleLineAutoResizeWithMaxWidth:0];
    
    self.lb_tag.sd_layout
    .centerYEqualToView(self.lb_title)
    .leftSpaceToView(self.lb_title, 6)
    .widthIs(30)
    .heightIs(15);
    
    self.lb_description.sd_layout
    .leftEqualToView(self.lb_title)
    .topSpaceToView(self.lb_title, 5)
    .heightIs(15);
    [self.lb_description setSingleLineAutoResizeWithMaxWidth:0];
    
    self.lb_author.sd_layout
    .rightSpaceToView(self.contentView, 12)
    .centerYEqualToView(self.lb_title)
    .heightIs(15);
    [self.lb_author setSingleLineAutoResizeWithMaxWidth:0];
    
    self.lb_all.sd_layout
    .rightEqualToView(self.lb_author)
    .centerYEqualToView(self.lb_description)
    .heightIs(15);
    [self.lb_all setSingleLineAutoResizeWithMaxWidth:0];
}

- (void)setModel:(ComicModel *)model {
    _model = model;
    [self.img_cover sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"today_list_placeholder_387x227_"]];
    self.lb_title.text = model.title;
    if (model.tagList && model.tagList.count > 0) {
        self.lb_tag.backgroundColor = hexColor(model.tagList[0].tagColor);
        self.lb_tag.text = model.tagList[0].tagStr;
    }
    self.lb_description.text = [@"更新至  " stringByAppendingString:model.comic_description];
    self.lb_author.text = model.author;
    [self setupAutoHeightWithBottomView:self.lb_description bottomMargin:16];

}


- (UIImageView *)img_cover {
    return C_LAZY(_img_cover, ({
        UIImageView *img = [UIImageView new];
        img;
    }));
}

- (UILabel *)lb_title {
    return C_LAZY(_lb_title, ({
        UILabel *lb = [UILabel new];
        lb.font = Y_Font(16);
        lb;
    }));
}

- (UILabel *)lb_tag {
    return C_LAZY(_lb_tag, ({
        UILabel *lb = [UILabel new];
        lb.textColor = [UIColor whiteColor];
        lb.font = Y_Font(9);
        lb.textAlignment = NSTextAlignmentCenter;
        lb.sd_cornerRadius = @7.5;
        lb;
    }));
}

- (UILabel *)lb_description {
    return C_LAZY(_lb_description, ({
        UILabel *lb = [UILabel new];
        lb.textColor = [UIColor lightGrayColor];
        lb.font = Y_Font(11);
        lb;
    }));
}

- (UILabel *)lb_author {
    return C_LAZY(_lb_author, ({
        UILabel *lb = [UILabel new];
        lb.textColor = [UIColor lightGrayColor];
        lb.font = Y_Font(11);
        lb;
    }));
}

- (UILabel *)lb_all {
    return C_LAZY(_lb_all, ({
        UILabel *lb = [UILabel new];
        lb.textColor = [UIColor lightGrayColor];
        lb.font = Y_Font(11);
        lb.text = @"全集 >";
        lb;
    }));
}

@end
