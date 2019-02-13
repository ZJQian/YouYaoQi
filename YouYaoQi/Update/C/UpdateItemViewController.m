//
//  UpdateItemViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/3.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "UpdateItemViewController.h"
#import "ComicModel.h"
#import "UpdateItemCell.h"
#import "DetailViewController.h"

@interface UpdateItemViewController ()

@end

@implementation UpdateItemViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.cTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-104);
    self.cTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.autoRowHeight = YES;
    [self.view addSubview:self.cTableView];
    
    __weak typeof(self) weakSelf = self;
    self.cellConfig = ^(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath, id  _Nonnull cell) {
        UpdateItemCell *c = cell;
        c.model = weakSelf.dataArray[indexPath.row];
        [c useCellFrameCacheWithIndexPath:indexPath tableView:weakSelf.cTableView];
    };
    self.didSelectCellConfig = ^(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath) {
        DetailViewController *vc = [[DetailViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    [self headerRefresh:YES];
    [self beginHeaderRefresh];
}

- (void)loadNewData {
    
    
    [CNetWorking getWithUrl:todayUpdate params:@{@"page": @0,@"day":self.weekday} success:^(id  _Nonnull response) {
        self.dataArray = [ComicModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"returnData"][@"comics"]];
        [self endRefresh];
    } failed:^(id  _Nonnull error) {
        [self endRefresh];
    }];
}


@end
