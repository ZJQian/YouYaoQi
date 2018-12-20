//
//  RankItemViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/7.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "RankItemViewController.h"
#import "RankTableViewCell.h"
#import "RankModel.h"

@interface RankItemViewController ()

@end

@implementation RankItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat distance = Nav_Height-Nav_Custom_Height+90;
    self.cTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-distance-self.navView.height-50);
    self.cTableView.separatorInset = UIEdgeInsetsZero;
    self.autoRowHeight = YES;
    [self.view addSubview:self.cTableView];
    
    __weak typeof(self) weakSelf = self;
    self.cellConfig = ^(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath, id  _Nonnull cell) {
        RankTableViewCell *c = cell;
        c.model = weakSelf.dataArray[indexPath.row];
        if (indexPath.row > 2) {
            c.img_rank.hidden = YES;
            c.lb_rank.hidden = NO;
            c.lb_rank.text = [NSString stringWithFormat:@"%02ld",indexPath.row+1];
        }else{
            c.lb_rank.hidden = YES;
            c.img_rank.hidden = NO;
            c.img_rank.image = [UIImage imageNamed:@[@"boutique_rank_1_40x46_",@"boutique_rank_2_40x46_",@"boutique_rank_3_40x46_"][indexPath.row]];
        }
        [c useCellFrameCacheWithIndexPath:indexPath tableView:weakSelf.cTableView];
    };
    [self headerRefresh:YES];
    if (self.index != 0) {
        [self beginHeaderRefresh];
    }else{
        self.dataArray = self.defaultRankArray;
    }
}

- (void)loadNewData {
    
    [CNetWorking getWithUrl:rankComicList params:@{@"page":@1,@"period":self.rankTabModel.defaultValue,@"type":@(self.rankTabModel.val)} success:^(id  _Nonnull response) {
        self.dataArray = [RankComicModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"returnData"][@"comics"]];
        [self endRefresh];
    } failed:^(id  _Nonnull error) {
        [self endRefresh];
    }];
}

@end
