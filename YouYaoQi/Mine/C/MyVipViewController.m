//
//  MyVipViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2019/1/11.
//  Copyright © 2019 zjq. All rights reserved.
//

#import "MyVipViewController.h"
#import "UIImage+YExt.h"

#define img             [UIImage imageNamed:@"sep_charge_vip_bg_1242x552_"]
#define height_bottom   50

@interface MyVipViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIScrollView         *           scroll;
@property (nonatomic, strong) UIImageView          *           img_ad;
@property (nonatomic, strong) NSMutableArray       *           dataArray;

@end

@implementation MyVipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isCustomNav = YES;
    self.navView.leftImgView.image = [UIImage imageNamed:@"info_back_white_42x42_"];
    self.navView.img_right = [UIImage imageNamed:@"oct_2017_vipCheck_20x20_"];
    self.navView.img_bg.image = [UIImage cropImage:img offSet:CGPointMake(0, 0) cropSize:CGSizeMake(1242, 1242*Nav_Custom_Height/SCREEN_WIDTH)];
    self.navView.lb_navTitle.text = @"我的VIP";
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
    [btn_open setBackgroundImage:[UIImage imageNamed:@"VIPbottombtn_1122x140_"] forState:UIControlStateNormal];
    [btn_open setTitle:@"立即开通" forState:UIControlStateNormal];
    btn_open.titleLabel.font = Y_Font(15);
    [v_bottom addSubview:btn_open];
    [btn_open mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(v_bottom);
        make.width.equalTo(v_bottom).multipliedBy(0.7);
        make.height.equalTo(btn_open.mas_width).multipliedBy(140.0/1120.0);
    }];
    
    CGFloat h = 552*SCREEN_WIDTH/1242-Nav_Custom_Height;
    UIImageView *img_header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h)];
    img_header.image = [UIImage cropImage:img offSet:CGPointMake(0, 1242*Nav_Custom_Height/SCREEN_WIDTH) cropSize:CGSizeMake(1242, 1242*h/SCREEN_WIDTH)];
    [self.scroll addSubview:img_header];
    
    
    UIView *v_loginInfo_bg = [[UIView alloc] initWithFrame:CGRectMake(20, img_header.height/2, SCREEN_WIDTH-40, (SCREEN_WIDTH-40)*0.3)];
    v_loginInfo_bg.backgroundColor = [UIColor whiteColor];
    v_loginInfo_bg.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    v_loginInfo_bg.layer.shadowOffset = CGSizeMake(0, 2);
    v_loginInfo_bg.layer.shadowOpacity = 0.3;
    v_loginInfo_bg.layer.shadowRadius = 3.0;
    v_loginInfo_bg.layer.cornerRadius = 9.0;
    v_loginInfo_bg.clipsToBounds = NO;
    [self.scroll addSubview:v_loginInfo_bg];
    
    UIView *v_loginInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, v_loginInfo_bg.width, v_loginInfo_bg.height)];
    [v_loginInfo_bg addSubview:v_loginInfo];
    
    CGFloat w_img_cartoon = SCREEN_WIDTH*0.15;
    CGFloat h_img_cartoon = w_img_cartoon*206/176;
    UIImageView *img_cartoon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vip_frist_Dec_176x206_"]];
    img_cartoon.frame = CGRectMake(v_loginInfo_bg.right-w_img_cartoon-10, v_loginInfo_bg.bottom-h_img_cartoon/2, w_img_cartoon, h_img_cartoon);
    [self.scroll addSubview:img_cartoon];
    
    
    CGFloat w_item = (SCREEN_WIDTH-60)/2.0;
    CGFloat h_item = w_item*414.0/546.0;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(w_item, h_item);
    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, img_cartoon.bottom+20, SCREEN_WIDTH, h_item) collectionViewLayout:layout];
    collect.delegate = self;
    collect.dataSource = self;
    collect.backgroundColor = [UIColor whiteColor];
    [self.scroll addSubview:collect];
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"moneyCell"];

    UIImageView *img_special = [[UIImageView alloc] initWithFrame:CGRectMake(0, collect.bottom+20, SCREEN_WIDTH, SCREEN_WIDTH*982/1242)];
    img_special.image = [UIImage imageNamed:@"sep_viplevel1_1242x982_"];
    [self.scroll addSubview:img_special];
    
    UIImageView *img_ad = [[UIImageView alloc] initWithFrame:CGRectMake(10, img_special.bottom+20, SCREEN_WIDTH-20, (SCREEN_WIDTH-20)*125/504)];
    [img_ad setConerRadius:9];
    [self.scroll addSubview:img_ad];
    self.img_ad = img_ad;
    
    
    UIButton *btn_more = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_more setTitle:@"更多 >" forState:UIControlStateNormal];
    [btn_more setTitleColor:Color_Content forState:UIControlStateNormal];
    [btn_more setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.1]];
    btn_more.titleLabel.font = Y_Font(12);
    CGFloat h_btn_more = SCREEN_WIDTH*0.7*46/333;
    btn_more.frame = CGRectMake(SCREEN_WIDTH*0.15, img_ad.bottom+20, SCREEN_WIDTH*0.7, h_btn_more);
    [btn_more setConerRadius:h_btn_more/2.0];
    [self.scroll addSubview:btn_more];
    
    
    UIButton *btn_pay = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_pay setTitle:@"查看充值记录" forState:UIControlStateNormal];
    [btn_pay setTitleColor:Color_Title forState:UIControlStateNormal];
    [btn_pay setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.1]];
    btn_pay.titleLabel.font = Y_Font(15);
    btn_pay.frame = CGRectMake(SCREEN_WIDTH*0.15, btn_more.bottom+20, SCREEN_WIDTH*0.7, h_btn_more);
    [btn_pay setConerRadius:h_btn_more/2.0];
    [self.scroll addSubview:btn_pay];
    
    self.scroll.contentSize = CGSizeMake(self.scroll.width, btn_pay.bottom+20);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"moneyCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    NSDictionary *dic = self.dataArray[indexPath.item];
    UIImageView *img_bg = [[UIImageView alloc] init];
    if ([dic[@"selected"] integerValue] == 1) {
        img_bg.image = [UIImage imageNamed:@"bgVipmeal_546x414_"];
    } else {
        img_bg.image = [UIImage imageNamed:@"bgVipmealno_546x414_"];
    }
    [cell.contentView addSubview:img_bg];
    [img_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    
    
    UIImageView *img_recommend = [[UIImageView alloc] init];
    [img_bg addSubview:img_recommend];
    [img_recommend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(img_bg);
    }];
    if (indexPath.item == 0) {
        img_recommend.image = [UIImage imageNamed:@"recommendCoin_63x35_"];
    }else {
        img_recommend.image = nil;
    }
    
    UILabel *lb_title = [UILabel new];
    lb_title.text = dic[@"title"];
    lb_title.textAlignment = NSTextAlignmentCenter;
    lb_title.font = Y_Font(14);
    lb_title.textColor = Color_Title;
    [img_bg addSubview:lb_title];
    [lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img_bg);
        make.top.equalTo(@20);
    }];
    
    UILabel *lb_price = [UILabel new];
    lb_price.text = dic[@"price"];
    lb_price.textAlignment = NSTextAlignmentCenter;
    lb_price.font = Y_Font(16);
    lb_price.textColor = [UIColor brownColor];
    [img_bg addSubview:lb_price];
    [lb_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img_bg);
        make.top.equalTo(lb_title.mas_bottom).offset(10);
    }];
    
    UILabel *lb_content = [UILabel new];
    lb_content.text = dic[@"subTitle"];
    lb_content.textAlignment = NSTextAlignmentCenter;
    lb_content.font = Y_Font(10);
    lb_content.textColor = Color_Content;
    [img_bg addSubview:lb_content];
    [lb_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img_bg);
        make.top.equalTo(lb_price.mas_bottom).offset(10);
    }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    for (NSMutableDictionary *dic in self.dataArray) {
        dic[@"selected"] = @"0";
    }
    self.dataArray[indexPath.item][@"selected"] = @"1";
    [collectionView reloadData];
}

#pragma mark - lazy

- (UIScrollView *)scroll {
    return C_LAZY(_scroll, ({
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Nav_Custom_Height, SCREEN_WIDTH, SCREEN_HEIGHT-Nav_Custom_Height-height_bottom)];
        [self.view addSubview:scrollView];
        scrollView;
    }));
}

- (NSMutableArray *)dataArray {
    return C_LAZY(_dataArray, ({
        NSMutableArray *array = [NSMutableArray arrayWithArray:@[[NSMutableDictionary dictionaryWithDictionary:@{@"selected": @"1",@"title":@"12个月VIP",@"price":@"¥88",@"subTitle":@"月费7.3元/月"}],[NSMutableDictionary dictionaryWithDictionary:@{@"selected": @"0",@"title":@"1个月VIP",@"price":@"¥18",@"subTitle":@"首月18元/月,续费8元/月"}]]];
        array;
    }));
}


@end
