//
//  DiscoverViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/3.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "DiscoverViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "BannerItemModel.h"
#import "RewardModel.h"
#import "FindTitleTableViewCell.h"
#import "FindFourItemTableViewCell.h"
#import "FindMoreTableViewCell.h"
#import "FindADTableViewCell.h"
#import "FindSixItemTableViewCell.h"
#import "FindMixTableViewCell.h"
#import "FindThreeItemTableViewCell.h"
#import "RewardCycleView.h"
#import "RankViewController.h"
#import "VipViewController.h"
#import "SubscribeViewController.h"
#import "MoreViewController.h"
#import "SearchViewController.h"

#define cycle_height SCREEN_WIDTH*663.0/984.0
#define img_height [UIImage imageNamed:@"find_hot_classificat_103x83_"].size.height*(SCREEN_WIDTH/4)/[UIImage imageNamed:@"find_hot_classificat_103x83_"].size.width
#define btn_tag  100

#define titleCellID         @"titleCell"
#define fourItemCellID      @"fourItemCell"
#define sixItemCellID       @"sixItemCell"
#define threeItemCellID     @"threeItemCell"
#define mixItemCellID       @"mixItemCell"
#define moreCellID          @"moreCell"
#define adCellID            @"adCell"

@interface DiscoverViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,FindMoreTableViewCellDelegate,UINavigationControllerDelegate>
{
    RewardCycleView *_cyView;
    UIButton *_btn_rank;
    UIButton *_btn_vip;
    UIButton *_btn_subscript;
    UIButton *_btn_classificat;
}
@property (nonatomic, strong) UITableView      *          findTableView;
@property (nonatomic, strong) SDCycleScrollView*          cycleScrollview;
@property (nonatomic, strong) UIView           *          headerView;
@property (nonatomic, strong) NSMutableArray   *          bannerArray;
@property (nonatomic, strong) NSMutableArray   *          dataArray;


@end

@implementation DiscoverViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self getData];
    [self setSubViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skinNoti:) name:kNotificationChangeSkin object:nil];
}


- (void)skinNoti:(NSNotification *)noti {
    NSDictionary *obj = noti.object;
    if (obj == nil) {
        NSArray *imgArray = @[@"find_hot_rank_103x83_",@"find_hot_vip_103x83_",@"find_hot_subscript_103x83_",@"find_hot_classificat_103x83_"];
        
        [_btn_rank setBackgroundImage:[UIImage imageNamed:imgArray[0]] forState:UIControlStateNormal];
        [_btn_vip setBackgroundImage:[UIImage imageNamed:imgArray[1]] forState:UIControlStateNormal];
        [_btn_subscript setBackgroundImage:[UIImage imageNamed:imgArray[2]] forState:UIControlStateNormal];
        [_btn_classificat setBackgroundImage:[UIImage imageNamed:imgArray[3]] forState:UIControlStateNormal];

    }else{
        NSString *path = obj[@"path"];
        NSDictionary *dic = obj[@"packageDic"];
        NSData *data0 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Find"][@"hotEntrance"][@"rankImage"] stringByAppendingString:@"@3x.png"]]];
        UIImage *img0 = [UIImage imageWithData:data0];
        
        NSData *data1 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Find"][@"hotEntrance"][@"vipImage"] stringByAppendingString:@"@3x.png"]]];
        UIImage *img1 = [UIImage imageWithData:data1];
        
        NSData *data2 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Find"][@"hotEntrance"][@"subscriptImage"] stringByAppendingString:@"@3x.png"]]];
        UIImage *img2 = [UIImage imageWithData:data2];
        
        NSData *data3 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Find"][@"hotEntrance"][@"classificatImage"] stringByAppendingString:@"@3x.png"]]];
        UIImage *img3 = [UIImage imageWithData:data3];
        
        [_btn_rank setBackgroundImage:img0 forState:UIControlStateNormal];
        [_btn_vip setBackgroundImage:img1 forState:UIControlStateNormal];
        [_btn_subscript setBackgroundImage:img2 forState:UIControlStateNormal];
        [_btn_classificat setBackgroundImage:img3 forState:UIControlStateNormal];
    }
    
}


- (void)getData {
    
    
    
    ///将两个数据请求加入一个异步执行dispatch_group, 等两个请求都执行完毕后,在进行下一步操作(即停止列表的下拉刷新或上拉加载)
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group,queue,^{
        
        [CNetWorking getWithUrl:detectList params:@{@"likeCate":@"",@"sexType":@3,@"v":@"3361000"} success:^(id  _Nonnull response) {
            
            self.bannerArray = [BannerItemModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"returnData"][@"galleryItems"]];
            self.dataArray = [FindComicModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"returnData"][@"comicLists"]];
            [self.dataArray removeObjectAtIndex:0];
            NSMutableArray *array = [NSMutableArray array];
            for (BannerItemModel *m in self.bannerArray) {
                [array addObject:m.cover];
            }
            self.cycleScrollview.imageURLStringsGroup = array;
            [self.findTableView reloadData];
        } failed:^(id  _Nonnull error) {
        }];
    });
    dispatch_group_async(group,queue,^{
        
        [CNetWorking getWithUrl:giftList success:^(id  _Nonnull response) {
            
            NSMutableArray *rewardArray = [NSMutableArray array];
            rewardArray = [RewardModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"returnData"]];
            self->_cyView.rewardArray = rewardArray;
        } failed:^(id  _Nonnull error) {
            
        }];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        [self.findTableView.mj_header endRefreshing];
    });
}

- (void)setSubViews {
    
    [self.findTableView addObserver:self forKeyPath:@"contentOffset" options: NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    [self.headerView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    
    [self.headerView addSubview:self.cycleScrollview];
    [self.cycleScrollview configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    
    UIView *v_bg0 = [UIView new];
    v_bg0.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    v_bg0.layer.shadowOffset = CGSizeMake(0, 2);
    v_bg0.layer.shadowOpacity = 0.3;
    v_bg0.layer.shadowRadius = 3.0;
    v_bg0.layer.cornerRadius = 9.0;
    v_bg0.clipsToBounds = NO;
    [self.headerView addSubview:v_bg0];
    [v_bg0 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
    }];
    
    NSMutableArray *imgSkinArray = [NSMutableArray array];
    if ([DefaultsUtil getSkin] != nil) {
        NSString *path = [GlobalUtil getSkinFolderPath];
        NSDictionary *dic = [GlobalUtil getSkinConfigFile];
        NSData *data0 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Find"][@"hotEntrance"][@"rankImage"] stringByAppendingString:@"@3x.png"]]];
        UIImage *img0 = [UIImage imageWithData:data0];
        
        NSData *data1 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Find"][@"hotEntrance"][@"vipImage"] stringByAppendingString:@"@3x.png"]]];
        UIImage *img1 = [UIImage imageWithData:data1];
        
        NSData *data2 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Find"][@"hotEntrance"][@"subscriptImage"] stringByAppendingString:@"@3x.png"]]];
        UIImage *img2 = [UIImage imageWithData:data2];
        
        NSData *data3 = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:[dic[@"Find"][@"hotEntrance"][@"classificatImage"] stringByAppendingString:@"@3x.png"]]];
        UIImage *img3 = [UIImage imageWithData:data3];
        [imgSkinArray addObjectsFromArray:@[img0,img1,img2,img3]];
    }
    
    NSArray *imgArray = @[@"find_hot_rank_103x83_",@"find_hot_vip_103x83_",@"find_hot_subscript_103x83_",@"find_hot_classificat_103x83_"];
    CGFloat w = SCREEN_WIDTH/4;
    for (int i = 0; i < imgArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([DefaultsUtil getSkin] == nil) {
            [btn setBackgroundImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        }else{
            [btn setBackgroundImage:imgSkinArray[i] forState:UIControlStateNormal];
        }
        btn.tag = btn_tag+i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [v_bg0 addSubview:btn];
        [btn configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.width = YGPointValue(w);
            layout.height = YGPointValue(img_height);
            layout.marginTop = YGPointValue(-8);
        }];
        switch (i) {
            case 0:
                _btn_rank = btn;
                break;
            case 1:
                _btn_vip = btn;
                break;
            case 2:
                _btn_subscript = btn;
                break;
            case 3:
                _btn_classificat = btn;
                break;
            default:
                break;
        }
    }
    
    
    UIView *v_bg = [UIView new];
    v_bg.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.08];
    [self.headerView addSubview:v_bg];
    [v_bg configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.padding = YGPointValue(10);
        layout.marginTop = YGPointValue(10);
        layout.alignItems = YGAlignCenter;
        layout.flexDirection = YGFlexDirectionRow;
    }];
    
    UIImageView *img = [UIImageView new];
    UIImage *img_reward = [UIImage imageNamed:@"boutique_reword_35x38_"];
    img.image = img_reward;
    [v_bg addSubview:img];
    [img configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    
    _cyView = [[RewardCycleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-img_reward.size.width-20-10, img_reward.size.height)];
    [v_bg addSubview:_cyView];
    [self.headerView.yoga applyLayoutPreservingOrigin:YES];
    
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置普通状态的动画图片
    [header setImages:@[[UIImage imageNamed:@"refresh_normal_121x76_"]] duration:0.8 forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:@[[UIImage imageNamed:@"refresh_will_refresh_121x76_"]] duration:0.8 forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:@[[UIImage imageNamed:@"refresh_loading_1_121x76_"],
                        [UIImage imageNamed:@"refresh_loading_2_121x76_"],
                        [UIImage imageNamed:@"refresh_loading_3_121x76_"]] duration:0.8 forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.findTableView.mj_header = header;
    [self.findTableView.mj_header beginRefreshing];
    
    
    self.isCustomNav = YES;
    [self.view addSubview:self.navView];
    [self.view bringSubviewToFront:self.navView];
    self.navView.backgroundColor = [UIColor clearColor];
    self.navView.img_left = [UIImage imageNamed:@"allSexImg_100x40_"];
    self.navView.img_right = [UIImage imageNamed:@"searchBtnNew_26x26_"];
    [self.navView.btn_right addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)loadNewData {
    
    [self getData];
}

- (void)rightBtnAction: (UIButton *)sender {
    
    SearchViewController *vc = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnAction:(UIButton *)sender {
    switch (sender.tag-btn_tag) {
        case 0:
            {
                RankViewController *vc = [[RankViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 1:
            {
                VipViewController *vc = [[VipViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 2:
            {
                SubscribeViewController *vc = [[SubscribeViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        default:
            break;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        NSValue *oldvalue = change[NSKeyValueChangeOldKey];
        NSValue *newvalue = change[NSKeyValueChangeNewKey];
        CGFloat oldoffset_y = oldvalue.UIOffsetValue.vertical;
        CGFloat newoffset_y = newvalue.UIOffsetValue.vertical;
        if (newoffset_y <= -Status_Height) {
            
            self.navView.backgroundColor = [UIColor clearColor];
            self.navView.frame = CGRectMake(0, 0, self.navView.width, self.navView.height);

        }else{
            
            if (newoffset_y > oldoffset_y) {
                
                if (newoffset_y == -Status_Height) {
                    self.navView.backgroundColor = [UIColor clearColor];
                    [UIView animateWithDuration:0.3 animations:^{
                        self.navView.frame = CGRectMake(0, 0, self.navView.width, self.navView.height);
                    }];
                    
                }else{
                    [UIView animateWithDuration:0.3 animations:^{
                        self.navView.backgroundColor = [UIColor whiteColor];
                        self.navView.frame = CGRectMake(0, -Nav_Custom_Height, self.navView.width, self.navView.height);
                    }];
                }
            } else if (newoffset_y < oldoffset_y) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.navView.backgroundColor = [UIColor whiteColor];
                    self.navView.frame = CGRectMake(0, 0, self.navView.width, self.navView.height);
                }];
            } else {
                if (newoffset_y == -Status_Height) {
                    self.navView.backgroundColor = [UIColor clearColor];
                    [UIView animateWithDuration:0.3 animations:^{
                        self.navView.frame = CGRectMake(0, 0, self.navView.width, self.navView.height);
                    }];
                    
                }
            }
        }
        
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - tableview delegate & datasource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    FindComicModel *model = self.dataArray[indexPath.section];
    if (indexPath.row == 0) {
        if (model.comicType == 20) {
            FindADTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adCellID];
            if (!cell) {
                cell = [[FindADTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adCellID];
            }
            cell.model = model;
            return cell;
        }else{
            FindTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCellID];
            if (!cell) {
                cell = [[FindTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleCellID];
            }
            cell.model = model;
            return cell;
        }

    }else if (indexPath.row == 1) {

        if (model.comicType == 3) {
            FindFourItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fourItemCellID];
            if (!cell) {
                cell = [[FindFourItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fourItemCellID];
            }
            cell.model = model;
            return cell;
        }else if (model.comicType == 17) {
            FindMixTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mixItemCellID];
            if (!cell) {
                cell = [[FindMixTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mixItemCellID];
            }
            cell.model = model;
            return cell;

        }else if (model.comicType == 18) {
            FindThreeItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:threeItemCellID];
            if (!cell) {
                cell = [[FindThreeItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:threeItemCellID];
            }
            cell.model = model;
            return cell;

        }else{
            FindSixItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sixItemCellID];
            if (!cell) {
                cell = [[FindSixItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sixItemCellID];
            }
            cell.model = model;
            return cell;
        }


    }else {

        FindMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellID];
        if (!cell) {
            cell = [[FindMoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellID];
        }
        cell.model = model;
        cell.delegate = self;
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FindComicModel *model = self.dataArray[section];
    if (model.comicType == 20) {
        return 1;
    }
    return (!model.canMore && !model.canChange) ? 2 : 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FindComicModel *model = self.dataArray[indexPath.section];
    if (indexPath.row == 0) {
        if (model.comicType == 20) {
            return SCREEN_WIDTH*328.0/984.0;
        }
        return 55.0;
    }else if (indexPath.row == 1) {
        if (model.comicType == 3) {
            CGFloat w = (SCREEN_WIDTH-4)/2.0;
            CGFloat h = w*578/984+60;
            return h*2;
        } else if(model.comicType == 17) {

            CGFloat h0 = SCREEN_WIDTH*296.0/504.0+60;
            CGFloat w = (SCREEN_WIDTH-8)/3.0;
            CGFloat h = w*639/484+60;
            return h0+h;

        } else if(model.comicType == 18) {

            CGFloat w = (SCREEN_WIDTH-8)/3.0;
            CGFloat h = w*639/484+60;
            return h;

        } else {
            CGFloat w = (SCREEN_WIDTH-8)/3.0;
            CGFloat h = w*639/484+60;
            return h*2;
        }
    }

    return 55.0;
}

#pragma mark - cell delegate

- (void)moreWithCell:(FindMoreTableViewCell *)cell {
    NSIndexPath *indexpath = [self.findTableView indexPathForCell:cell];
    FindComicModel *model = self.dataArray[indexpath.section];
    MoreViewController *vc = [[MoreViewController alloc] initWithReuseIdentifier:@"moreCell" cellType:@"MoreTableViewCell"];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)changeWithCell:(FindMoreTableViewCell *)cell {
    
}

#pragma mark - cycle delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

#pragma mark - navigation delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isShow = [viewController isKindOfClass:[DiscoverViewController class]];
    [self.navigationController setNavigationBarHidden:isShow animated:YES];
}

- (void)dealloc {
    [self.findTableView removeObserver:self forKeyPath:@"contentOffset"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - lazy
- (UITableView *)findTableView {
    return C_LAZY(_findTableView, ({
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, -Status_Height, SCREEN_WIDTH, SCREEN_HEIGHT+Status_Height) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.tableHeaderView = self.headerView;
        table.tableFooterView = [UIView new];
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:table];
        [self.view sendSubviewToBack:table];
        table;
    }));
}

- (SDCycleScrollView *)cycleScrollview {
    return C_LAZY(_cycleScrollview, ({
        SDCycleScrollView *cycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, cycle_height) delegate:self placeholderImage:[UIImage imageNamed:@"today_list_placeholder_387x227_"]];
        cycle.autoScrollTimeInterval = 5;
        cycle;
    }));
}

- (UIView *)headerView {
    return C_LAZY(_headerView, ({
        UIImage *image = [UIImage imageNamed:@"boutique_reword_35x38_"];
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, cycle_height+img_height+image.size.height+20+10)];
        v.backgroundColor = [UIColor whiteColor];
        v;
    }));
}

- (NSMutableArray *)bannerArray {
    return C_LAZY(_bannerArray, ({
        NSMutableArray *array = [NSMutableArray array];
        array;
    }));
}
- (NSMutableArray *)dataArray {
    return C_LAZY(_dataArray, ({
        NSMutableArray *array = [NSMutableArray array];
        array;
    }));
}


@end
