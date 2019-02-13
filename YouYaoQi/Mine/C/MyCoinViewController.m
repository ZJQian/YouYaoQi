//
//  MyCoinViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2019/1/11.
//  Copyright © 2019 zjq. All rights reserved.
//

#import "MyCoinViewController.h"
#import "UIImage+YExt.h"

#define img             [UIImage imageNamed:@"sep_charge_coin_bg_1242x730_"]
#define height_bottom   50


@interface MyCoinViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) UIScrollView         *           scroll;
@property (nonatomic, strong) UIImageView          *           img_ad;


@end

@implementation MyCoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isCustomNav = YES;
    self.navView.leftImgView.image = [UIImage imageNamed:@"info_back_white_42x42_"];
    self.navView.img_right = [UIImage imageNamed:@"oct_2017_vipCheck_20x20_"];
    self.navView.img_bg.image = [UIImage cropImage:img offSet:CGPointMake(0, 0) cropSize:CGSizeMake(1242, 1242*Nav_Custom_Height/SCREEN_WIDTH)];
    self.navView.lb_navTitle.text = @"我的妖气币";
    self.navView.lb_navTitle.textColor = [UIColor whiteColor];
    
    [self setSubViews];

    
    [CNetWorking getWithUrl:adLocat params:@{@"locat_id":@"33"} success:^(id  _Nonnull response) {
        
        NSString *cover_url = response[@"data"][@"returnData"][0][@"cover"];
        [self.img_ad sd_setImageWithURL:[NSURL URLWithString:cover_url]];
    } failed:^(id  _Nonnull error) {
        
    }];
    
}


- (void)setSubViews {
    
    UIView *v_bottom = [[UIView alloc] init];
    v_bottom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v_bottom];
    [v_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(height_bottom));
    }];
    
    UIButton *btn_open = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_open setBackgroundImage:[UIImage imageNamed:@"Coinbottombtn_1122x140_"] forState:UIControlStateNormal];
    [btn_open setTitle:@"立即支付" forState:UIControlStateNormal];
    btn_open.titleLabel.font = Y_Font(15);
    [v_bottom addSubview:btn_open];
    [btn_open mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(v_bottom);
        make.width.equalTo(v_bottom).multipliedBy(0.7);
        make.height.equalTo(btn_open.mas_width).multipliedBy(140.0/1120.0);
    }];
    
    CGFloat h = 730*SCREEN_WIDTH/1242-Nav_Custom_Height;
    UIImageView *img_header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h)];
    img_header.image = [UIImage cropImage:img offSet:CGPointMake(0, 1242*Nav_Custom_Height/SCREEN_WIDTH) cropSize:CGSizeMake(1242, 1242*h/SCREEN_WIDTH)];
    [self.scroll addSubview:img_header];
    
    
    UIImageView *img_ad = [[UIImageView alloc] initWithFrame:CGRectMake(15, img_header.bottom+20, SCREEN_WIDTH-30, (SCREEN_WIDTH-30)*125/504)];
    [img_ad setConerRadius:9];
    [self.scroll addSubview:img_ad];
    self.img_ad = img_ad;
    
    CGFloat w_item = (SCREEN_WIDTH-60)/3.0;
    CGFloat h_item = w_item*450.0/350.0;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(w_item, h_item);
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    layout.minimumLineSpacing = 15;
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, img_ad.bottom+20, SCREEN_WIDTH, h_item*2+15) collectionViewLayout:layout];
    collect.delegate = self;
    collect.dataSource = self;
    collect.backgroundColor = [UIColor whiteColor];
    [self.scroll addSubview:collect];
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"moneyCell"];
    
    UIImageView *img_for = [[UIImageView alloc] initWithFrame:CGRectMake(0, collect.bottom+20, SCREEN_WIDTH, SCREEN_WIDTH*203/621)];
    img_for.image = [UIImage imageNamed:@"july_coin_use_621x203_"];
    [self.scroll addSubview:img_for];
    
    UIButton *btn_more = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_more setTitle:@"查看消费记录" forState:UIControlStateNormal];
    [btn_more setTitleColor:Color_Title forState:UIControlStateNormal];
    [btn_more setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.1]];
    btn_more.titleLabel.font = Y_Font(15);
    CGFloat h_btn_more = SCREEN_WIDTH*0.7*46/333;
    btn_more.frame = CGRectMake(SCREEN_WIDTH*0.15, img_for.bottom+20, SCREEN_WIDTH*0.7, h_btn_more);
    [btn_more setConerRadius:h_btn_more/2.0];
    [self.scroll addSubview:btn_more];
    
    self.scroll.contentSize = CGSizeMake(self.scroll.width, btn_more.bottom+20);

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"moneyCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    UIImageView *img_bg = [[UIImageView alloc] init];
    img_bg.image = [UIImage imageNamed:@"bgJuneCoinCell_350x450_"];
    [cell.contentView addSubview:img_bg];
    [img_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    
    NSArray *imgArray = @[@"oneMoney_46x50_",
                          @"twoMoney_62x50_",
                          @"threeMoney_61x50_",
                          @"threeMoney_61x50_",
                          @"threeMoney_61x50_",
                          @"threeMoney_61x50_"];
    NSArray *coinArray = @[@"600妖气币",@"3000妖气币",@"5000妖气币",@"9800妖气币",@"198000妖气币",@"388000妖气币"];
    NSArray *priceArray = @[@"¥6",@"¥30",@"¥50",@"¥98",@"¥198",@"¥388"];
    UIImageView *img_coin = [[UIImageView alloc] init];
    img_coin.image = [UIImage imageNamed:imgArray[indexPath.item]];
    [img_bg addSubview:img_coin];
    [img_coin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img_bg);
        make.centerY.equalTo(@(-20));
    }];
    
    
    UIImageView *img_recommend = [[UIImageView alloc] init];
    [img_bg addSubview:img_recommend];
    [img_recommend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(img_bg);
    }];
    if (indexPath.item == 1) {
        img_recommend.image = [UIImage imageNamed:@"recommendCoin_63x35_"];
    }else {
        img_recommend.image = nil;
    }
    
    UILabel *lb_coin = [UILabel new];
    lb_coin.text = coinArray[indexPath.item];
    lb_coin.textAlignment = NSTextAlignmentCenter;
    lb_coin.font = Y_Font(11);
    lb_coin.textColor = Color_Title;
    [img_bg addSubview:lb_coin];
    [lb_coin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img_coin);
        make.centerY.equalTo(@20);
    }];
    
    UILabel *lb_price = [UILabel new];
    lb_price.text = priceArray[indexPath.item];
    lb_price.textAlignment = NSTextAlignmentCenter;
    lb_price.font = Y_Font(12);
    lb_price.textColor = [UIColor whiteColor];
    [img_bg addSubview:lb_price];
    [lb_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img_coin);
        make.bottom.equalTo(cell.contentView).offset(-6);
    }];
    
    return cell;
}

#pragma mark - lazy

- (UIScrollView *)scroll {
    return C_LAZY(_scroll, ({
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Nav_Custom_Height, SCREEN_WIDTH, SCREEN_HEIGHT-Nav_Custom_Height-height_bottom)];
        [self.view addSubview:scrollView];
        scrollView;
    }));
}




@end
