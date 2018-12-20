//
//  MineViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/3.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "MineViewController.h"
#import "SkinViewController.h"
#import "SettingViewController.h"
#import "WalletViewController.h"
#import "CWebViewController.h"
#import "AuthorViewController.h"

static NSInteger item_tag = 100;
@interface MineViewController ()<UINavigationControllerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView        *         bgScrollView;
@property (nonatomic, strong) UIImageView         *         img_header;

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setSubViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skinNoti:) name:kNotificationChangeSkin object:nil];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)skinNoti:(NSNotification *)noti {
    NSDictionary *obj = noti.object;
    if (obj == nil) {
        self.img_header.image = [UIImage imageNamed:@"mine_sky_bg_621x310_"];
    }else{
        NSString *path = obj[@"path"];
        NSDictionary *dic = obj[@"packageDic"];
        NSData *data = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Mine"][@"tableHeaderBgImage"] stringByAppendingString:@".png"]]];
        UIImage *img = [UIImage imageWithData:data];
        self.img_header.image = img;
    }
    
}

- (void)setSubViews {
    
    [self.bgScrollView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    
    UIView *contentView = [UIView new];
    [contentView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    
    UIView *v_header = [UIView new];
    [contentView addSubview:v_header];
    [v_header configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.justifyContent = YGJustifyCenter;
    }];
    
    UIImageView *img_avatar_bg = [UIImageView new];
    if ([DefaultsUtil getSkin] == nil) {
        img_avatar_bg.image = [UIImage imageNamed:@"mine_sky_bg_621x310_"];
    }else{
        NSString *path = [GlobalUtil getSkinFolderPath];
        NSDictionary *dic = [GlobalUtil getSkinConfigFile];
        NSData *data = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Mine"][@"tableHeaderBgImage"] stringByAppendingString:@".png"]]];
        UIImage *img = [UIImage imageWithData:data];
        img_avatar_bg.image = img;
    }
    [v_header addSubview:img_avatar_bg];
    [img_avatar_bg configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(SCREEN_WIDTH);
        layout.height = YGPointValue(SCREEN_WIDTH*310.0/621.0);
        layout.marginBottom = YGPointValue(-15);
    }];
    self.img_header = img_avatar_bg;
    
    
    UIView *v_header2 = [UIView new];
    [v_header addSubview:v_header2];
    [v_header2 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.alignItems = YGAlignCenter;
        layout.flexDirection = YGFlexDirectionRow;
        layout.marginHorizontal = YGPointValue(12);
        layout.position = YGPositionTypeAbsolute;
    }];
    
    UIImageView *img_avatar = [UIImageView new];
    img_avatar.image = [UIImage imageNamed:@"v3_mine_unlogicon_73x73_"];
    [v_header2 addSubview:img_avatar];
    [img_avatar configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.marginLeft = YGPointValue(12);
    }];
    
    UILabel *lb_notice = [UILabel new];
    lb_notice.text = @"主人, 快戳我登录呀";
    lb_notice.font = [UIFont boldSystemFontOfSize:20];
    lb_notice.textColor = [UIColor whiteColor];
    [v_header2 addSubview:lb_notice];
    [lb_notice configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.marginLeft = YGPointValue(10);
    }];
    
    
    UIView *v_money_bg = [UIView new];
    v_money_bg.backgroundColor = [UIColor whiteColor];
    v_money_bg.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    v_money_bg.layer.shadowOffset = CGSizeMake(0, 2);
    v_money_bg.layer.shadowOpacity = 0.3;
    v_money_bg.layer.shadowRadius = 3.0;
    v_money_bg.layer.cornerRadius = 9.0;
    v_money_bg.clipsToBounds = NO;
    [contentView addSubview:v_money_bg];
    [v_money_bg configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.marginHorizontal = YGPointValue(12);
        layout.marginBottom = YGPointValue(30);
    }];
    
    
    UIView *v_money = [UIView new];
    [v_money_bg addSubview:v_money];
    [v_money configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.paddingVertical = YGPointValue(20);
        layout.justifyContent = YGJustifySpaceAround;
        layout.alignItems = YGAlignCenter;
    }];
    
    
    for (int i = 0; i < 2; i++) {
        UIView *v_item = [UIView new];
        [v_money addSubview:v_item];
        [v_item configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.justifyContent = YGJustifyCenter;
            layout.alignItems = YGAlignCenter;
        }];
        
        UILabel *lb = [UILabel new];
        lb.text = @[@"未开通",@"余额0"][i];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = Y_Font(13);
        [v_item addSubview:lb];
        [lb configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
        }];
        
        UILabel *lb2 = [UILabel new];
        lb2.text = @[@"我的VIP",@"我的妖气币"][i];
        lb2.textColor = [UIColor lightGrayColor];
        lb2.font = Y_Font(12);
        lb2.textAlignment = NSTextAlignmentCenter;
        [v_item addSubview:lb2];
        [lb2 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.marginTop = YGPointValue(6);
        }];
    }
    
    UIView *v = [UIView new];
    [contentView addSubview:v];
    [v configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.justifyContent = YGJustifySpaceAround;
        layout.flexDirection = YGFlexDirectionRow;
        layout.flexWrap = YGWrapWrap;
    }];
    NSArray *imgArray = @[@{@"img":@"sep_register_180x180_",@"title":@"签到"},
                          @{@"img":@"sep_mywallet_180x180_",@"title":@"钱包"},
                          @{@"img":@"sep_subscription_180x180_",@"title":@"订阅"},
                          @{@"img":@"sep_fengyintu_180x180_",@"title":@"封印图"},
                          @{@"img":@"sep_theme_180x180_",@"title":@"皮肤"},
                          @{@"img":@"sep_help_180x180_",@"title":@"帮助反馈"},
                          @{@"img":@"sep_beijing_180x180_",@"title":@"首都网警"},
                          @{@"img":@"sep_auther_180x180_",@"title":@"作者中心"},
                          @{@"img":@"sep_setting_180x180_",@"title":@"设置"}];
    
    for (int i = 0; i < imgArray.count; i++) {
        UIView *v_item = [UIView new];
        [v_item setUserInteractionEnabled:YES];
        v_item.tag = item_tag+i;
        [v addSubview:v_item];
        [v_item configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.width = layout.height = YGPointValue(SCREEN_WIDTH/3.0);
            layout.alignItems = YGAlignCenter;
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [v_item addGestureRecognizer:tap];
        
        UIImageView *img = [UIImageView new];
        img.image = [UIImage imageNamed:imgArray[i][@"img"]];
        [v_item addSubview:img];
        [img configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.width = layout.height = YGPercentValue(40);
        }];
        
        UILabel *lb = [UILabel new];
        lb.text = imgArray[i][@"title"];
        lb.font = Y_Font(13);
        lb.textAlignment = NSTextAlignmentCenter;
        [v_item addSubview:lb];
        
        
    }
    [self.bgScrollView addSubview:contentView];
    [self.bgScrollView.yoga applyLayoutPreservingOrigin:YES];
    self.bgScrollView.contentSize = contentView.bounds.size;
}

#pragma mark - action
- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    switch (tap.view.tag-item_tag) {
        case 1:
        {
            WalletViewController *vc = [[WalletViewController alloc] initWithReuseIdentifier:@"walletCell" cellType:@"UITableViewCell"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
            {
                SkinViewController *vc = [[SkinViewController alloc] initWithReuseIdentifier:@"skinCell" cellType:@"SkinTableViewCell"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 6:
        {
            CWebViewController *vc = [[CWebViewController alloc] init];
            vc.webURL = police;
            vc.leftText = @"我的";
            vc.navText = @"首都网警";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:
        {
            AuthorViewController *vc = [[AuthorViewController alloc] initWithReuseIdentifier:@"authorCell" cellType:@"UITableViewCell"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 8:
        {
            SettingViewController *vc = [[SettingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark - delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isShow = [viewController isKindOfClass:[MineViewController class]];
    [navigationController setNavigationBarHidden:isShow animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat width = SCREEN_WIDTH; // 图片宽度
    CGFloat yOffset = scrollView.contentOffset.y;  // 偏移的y值
    CGFloat h = SCREEN_WIDTH*310.0/621.0;
    if (yOffset < 0) {
        CGFloat totalOffset = h + ABS(yOffset);
        CGFloat f = totalOffset / h;
        self.img_header.frame =  CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset); //拉伸后的图片的frame应该是同比例缩放。
    }
    
    
}

#pragma mark - lazy

- (UIScrollView *)bgScrollView {
    return C_LAZY(_bgScrollView, ({
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -Status_Height, SCREEN_WIDTH, SCREEN_HEIGHT)];
        scroll.delegate = self;
        [self.view addSubview:scroll];
        scroll;
    }));
}

@end
