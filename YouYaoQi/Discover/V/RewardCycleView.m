//
//  RewardCycleView.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/6.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "RewardCycleView.h"
#import "RewardModel.h"

@interface RewardCycleView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

{
    UICollectionViewFlowLayout *_flowLayout;
}
@property (nonatomic, strong) UICollectionView          *               collect;
@property (nonatomic, strong) NSTimer      *      timer;


@end

@implementation RewardCycleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.marginLeft = YGPointValue(10);
        }];
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        layout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 20;
        _flowLayout.estimatedItemSize = CGSizeMake(frame.size.height, frame.size.height);
        UICollectionView *c = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
        c.delegate = self;
        c.dataSource = self;
        c.backgroundColor = [UIColor clearColor];
        c.showsHorizontalScrollIndicator = NO;
        [self addSubview:c];
        [c registerClass:[RewardCell class] forCellWithReuseIdentifier:@"rewardCell"];
        self.collect = c;
    }
    return self;
}

- (void)setRewardArray:(NSMutableArray *)rewardArray {
    _rewardArray = rewardArray;
    
    [self.collect reloadData];
    [self setupTimer];
}

- (void)automaticScroll {
    
    [UIView animateWithDuration:1 animations:^{
        CGPoint offset = self.collect.contentOffset;
        offset.x += 5;
        self.collect.contentOffset = offset;
    }];
}

- (void)setupTimer
{
    [self invalidateTimer]; // 创建定时器前先停止定时器，不然会出现僵尸定时器，导致轮播频率错误
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.rewardArray.count) return; // 解决清除timer时偶尔会出现的问题
    if (scrollView == self.collect) {
        CGFloat w = scrollView.frame.size.width;
        CGFloat contentXoffset = scrollView.contentOffset.x;
        CGFloat distanceFromRight = scrollView.contentSize.width - contentXoffset;
        if (distanceFromRight < w) {
            
            [self.collect scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];

        }
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.collect];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (!self.rewardArray.count) return; // 解决清除timer时偶尔会出现的问题
    
}


#pragma mark - delegate & datasource
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellID = @"rewardCell";
    RewardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    long index = indexPath.item%self.rewardArray.count;
    cell.model = self.rewardArray[index];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rewardArray.count*100;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeZero;
}


@end

@interface RewardCell ()

@property (nonatomic, strong) UIImageView        *         img_head;
@property (nonatomic, strong) UILabel        *         lb_content;
@property (nonatomic, strong) UILabel        *         lb_reward;

@end

@implementation RewardCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.img_head];
        [self.contentView addSubview:self.lb_content];
        [self.contentView addSubview:self.lb_reward];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    [self.img_head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(weakSelf.contentView);
        make.width.height.equalTo(@25);
    }];
    [self.lb_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.img_head);
        make.left.equalTo(weakSelf.img_head.mas_right).offset(6);
        make.width.greaterThanOrEqualTo(@0.1);
        make.height.greaterThanOrEqualTo(@0.1);
        make.height.equalTo(weakSelf.contentView).priorityLow();
    }];
    
    [self.lb_reward mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.img_head);
        make.left.mas_equalTo(weakSelf.lb_content.mas_right).offset(3);
        make.width.greaterThanOrEqualTo(@0.1);
        make.height.greaterThanOrEqualTo(@0.1);
        make.right.equalTo(weakSelf.contentView).priorityLow();
        make.height.equalTo(weakSelf.contentView).priorityLow();
        
    }];

}

- (void)setModel:(RewardModel *)model {
    _model = model;
    [self.img_head sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@""]];
    self.lb_content.text = [NSString stringWithFormat:@"%@*** 打赏《%@》",[model.nickname substringToIndex:1],model.comicName];
    self.lb_reward.text = [NSString stringWithFormat:@"%@ x %ld",model.giftName,model.giftCount];
    [self layoutIfNeeded];
}


- (UIImageView *)img_head {
    return C_LAZY(_img_head, ({
        UIImageView *img = [UIImageView new];
        [img setConerRadius:12.5];
        img;
    }));
}

- (UILabel *)lb_content {
    return C_LAZY(_lb_content, ({
        UILabel *lb = [UILabel new];
        lb.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        lb.font = Y_Font(12);
        lb;
    }));
}

- (UILabel *)lb_reward {
    return C_LAZY(_lb_reward, ({
        UILabel *lb = [UILabel new];
        lb.textColor = [[UIColor orangeColor] colorWithAlphaComponent:0.8];
        lb.font = Y_Font(15);
        lb;
    }));
}

@end
