//
//  FindFourItemTableViewCell.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/5.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "FindFourItemTableViewCell.h"

@interface FindFourItemTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) UICollectionView       *        collect;
@property (nonatomic, copy) NSArray       *        dataArray;

@end

@implementation FindFourItemTableViewCell


- (void)setSubViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.collect];
    [self.collect registerClass:[ItemCell class] forCellWithReuseIdentifier:@"findFourCell"];
}


- (void)setModel:(FindComicModel *)model {
    _model = model;
    self.dataArray = model.comics;
    
    [self.collect reloadData];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - LAZY

- (UICollectionView *)collect {
    return C_LAZY(_collect, ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat w = (SCREEN_WIDTH-4)/2.0;
        CGFloat h = (w*578.0/984.0+60);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 4;
        layout.itemSize = CGSizeMake(w, h);
        UICollectionView *c = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h*2) collectionViewLayout:layout];
        c.backgroundColor = [UIColor whiteColor];
        c.showsVerticalScrollIndicator = NO;
        c.scrollEnabled = NO;
        c.delegate = self;
        c.dataSource = self;
        c;
    }));
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellID = @"findFourCell";
    ItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count >= 4 ? 4 : self.dataArray.count;
}



@end

@interface ItemCell ()

@property (nonatomic, strong) UIImageView     *        img_cover;
@property (nonatomic, strong) UILabel     *        lb_title;
@property (nonatomic, strong) UILabel     *        lb_description;

@end
@implementation ItemCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.img_cover];
        [self.contentView addSubview:self.lb_title];
        [self.contentView addSubview:self.lb_description];
        
        [self.img_cover mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.width.equalTo(self.img_cover.mas_height).multipliedBy(984.0/578.0);
        }];
        
        [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@8);
            make.top.equalTo(self.img_cover.mas_bottom).offset(12);
            make.right.equalTo(@(-8));
        }];
        
        [self.lb_description mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.lb_title);
            make.top.equalTo(self.lb_title.mas_bottom).offset(6);
        }];
    }
    return self;
}


- (void)setModel:(FindComicItemModel *)model {
    _model = model;
    
    [self.img_cover sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"boutique_horizontal_placeholder_205x128_"]];
    self.lb_title.text = model.name;
    self.lb_description.text = model.short_description;
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
        lb.font = Y_Font(14);
        lb.numberOfLines = 1;
        lb;
    }));
}

- (UILabel *)lb_description {
    return C_LAZY(_lb_description, ({
        UILabel *lb = [UILabel new];
        lb.font = Y_Font(12);
        lb.textColor = [UIColor lightGrayColor];
        lb.numberOfLines = 1;
        lb;
    }));
}

@end
