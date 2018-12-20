//
//  FindMixTableViewCell.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/5.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "FindMixTableViewCell.h"

@interface FindMixTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UICollectionView       *        collect;
@property (nonatomic, strong) UICollectionViewFlowLayout       *        flowlayout;
@property (nonatomic, copy) NSArray       *        dataArray;

@end

@implementation FindMixTableViewCell


- (void)setSubViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.collect];
    [self.collect registerClass:[MixItemCell class] forCellWithReuseIdentifier:@"findMixCell"];
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
        self.flowlayout = layout;
        CGFloat w = (SCREEN_WIDTH-8.0)/3.0;
        CGFloat h0 = SCREEN_WIDTH*296.0/504.0+60;
        CGFloat h = (w*639.0/484.0+60);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 4;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        UICollectionView *c = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h0+h) collectionViewLayout:layout];
        c.backgroundColor = [UIColor whiteColor];
        c.showsVerticalScrollIndicator = NO;
        c.scrollEnabled = NO;
        c.delegate = self;
        c.dataSource = self;
        c;
    }));
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellID = @"findMixCell";
    MixItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.item == 0) {
        [cell.img_cover mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(cell.contentView);
            make.width.equalTo(cell.img_cover.mas_height).multipliedBy(504.0/296.0);
        }];
    }else{
        [cell.img_cover mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(cell.contentView);
            make.width.equalTo(cell.img_cover.mas_height).multipliedBy(484.0/639.0);
        }];
    }
    
    
    [cell.lb_title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.top.equalTo(cell.img_cover.mas_bottom).offset(12);
        make.right.equalTo(@(-8));
    }];
    
    [cell.lb_description mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(cell.lb_title);
        make.top.equalTo(cell.lb_title.mas_bottom).offset(6);
    }];
    
    
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count >= 4 ? 4 : self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        return self.flowlayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*296.0/504.0+60);
    }else{
        CGFloat w = (SCREEN_WIDTH-8)/3.0;
        CGFloat h = (w*639.0/484.0+60);
        return self.flowlayout.itemSize = CGSizeMake(w-0.1, h);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}

@end

@interface MixItemCell ()



@end
@implementation MixItemCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.img_cover];
        [self.contentView addSubview:self.lb_title];
        [self.contentView addSubview:self.lb_description];
    }
    return self;
}


- (void)setModel:(FindComicItemModel *)model {
    _model = model;
    
    [self.img_cover sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"boutique_placeholder_139x176_"]];
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

