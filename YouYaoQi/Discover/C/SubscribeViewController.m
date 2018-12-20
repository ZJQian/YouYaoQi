//
//  SubscribeViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/10.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "SubscribeViewController.h"
#import "UIImage+YExt.h"
#import "BannerItemModel.h"
#import "FindTitleTableViewCell.h"
#import "FindFourItemTableViewCell.h"
#import "FindMoreTableViewCell.h"
#import "FindADTableViewCell.h"
#import "FindSixItemTableViewCell.h"
#import "FindMixTableViewCell.h"
#import "FindThreeItemTableViewCell.h"


#define titleCellID         @"vip_titleCell"
#define fourItemCellID      @"vip_fourItemCell"
#define sixItemCellID       @"vip_sixItemCell"
#define threeItemCellID     @"vip_threeItemCell"
#define mixItemCellID       @"vip_mixItemCell"
#define moreCellID          @"vip_moreCell"
#define adCellID            @"vip_adCell"

#define img     [UIImage imageNamed:@"orderBg_621x470_"]


@interface SubscribeViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView      *          subscribeTableView;
@property (nonatomic, strong) NSMutableArray   *          dataArray;
@property (nonatomic, strong) UIImageView      *          headerView;

@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.delegate = self;
    self.isCustomNav = YES;
    self.navView.img_left = [UIImage imageNamed:@"info_back_white_42x42_"];
    self.navView.img_bg.image = [UIImage cropImage:img offSet:CGPointMake(0, 0) cropSize:CGSizeMake(1242, 1242*Nav_Custom_Height/SCREEN_WIDTH)];
    self.navView.lb_navTitle.text = @"订阅";
    self.navView.lb_navTitle.textColor = [UIColor whiteColor];
    [CNetWorking getWithUrl:newSubscribeList params:@{@"sexType":@3} success:^(id  _Nonnull response) {
        self.dataArray = [FindComicModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"returnData"][@"newSubscribeList"]];
        [self.subscribeTableView reloadData];
    } failed:^(id  _Nonnull error) {
        
    }];
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
            if (indexPath.section == 0) {
                cell.img_bg.image = [UIImage cropImage:img offSet:CGPointMake(0, 1242*Nav_Custom_Height/SCREEN_WIDTH*4) cropSize:CGSizeMake(1242, 1242*44.0/SCREEN_WIDTH)];
            }else {
                cell.img_bg.image = nil;
            }
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
            
        }else if (model.comicType == 18 || model.comicType == 7) {
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
            
        } else if(model.comicType == 18 || model.comicType == 7) {
            
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


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isShow = [viewController isKindOfClass:[SubscribeViewController class]];
    [navigationController setNavigationBarHidden:isShow animated:YES];
}


#pragma mark - lazy
- (UITableView *)subscribeTableView {
    return C_LAZY(_subscribeTableView, ({
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, Nav_Custom_Height, SCREEN_WIDTH, SCREEN_HEIGHT-Nav_Custom_Height) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.tableHeaderView = self.headerView;
        table.tableFooterView = [UIView new];
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:table];
        table;
    }));
}

- (NSMutableArray *)dataArray {
    return C_LAZY(_dataArray, ({
        NSMutableArray *array = [NSMutableArray array];
        array;
    }));
}

- (UIImageView *)headerView {
    return C_LAZY(_headerView, ({
        UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Nav_Custom_Height*3)];
        v.image = [UIImage cropImage:img offSet:CGPointMake(0, 1242*Nav_Custom_Height/SCREEN_WIDTH) cropSize:CGSizeMake(1242, 1242*Nav_Custom_Height/SCREEN_WIDTH*3)];
        v;
    }));
}

@end
