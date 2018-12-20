//
//  CBaseTableViewController.m
//  OC_Cloud
//
//  Created by ZJQian on 2018/11/30.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "CBaseTableViewController.h"
#import "ComicModel.h"
#import "BannerItemModel.h"
#import "MoreModel.h"

@interface CBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>


@end

@implementation CBaseTableViewController

- (instancetype)init{
    return [self initWithReuseIdentifier:nil cellType:nil dataArray:nil];
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    return [self initWithReuseIdentifier:reuseIdentifier cellType:nil dataArray:nil];
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier cellType:(NSString *)cellType {
    return [self initWithReuseIdentifier:reuseIdentifier cellType:cellType dataArray:nil];
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier dataArray:(NSMutableArray *)dataArray {
    return [self initWithReuseIdentifier:reuseIdentifier cellType:nil dataArray:dataArray];
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
                               cellType:(NSString *)cellType
                              dataArray:(NSMutableArray *)dataArray {
    
    self = [super init];
    if (self) {
        self.reuseIdentifier = reuseIdentifier ? reuseIdentifier : @"";
        if (dataArray) {
            self.dataArray = dataArray;
        }
        if (cellType) {
            self.cellType = cellType;
            Class cell = NSClassFromString(cellType);
            [self.cTableView registerClass:cell forCellReuseIdentifier:reuseIdentifier];
        }else{
            self.cellType = @"";
        }
        self.cTableView.emptyDataSetDelegate = self;
        self.cTableView.emptyDataSetSource = self;
        self.autoRowHeight = NO;
        self.isSectionTable = NO;
        self.y_rowheight = 0;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - tableView delegate & datasource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSString *cellId = self.reuseIdentifier;
    id cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (self.cellConfig) {
        self.cellConfig(tableView, indexPath, cell);
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.isSectionTable ? self.dataArray.count : 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.isSectionTable ? [self.dataArray[section] count] : self.dataArray.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectCellConfig) {
        self.didSelectCellConfig(tableView, indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.autoRowHeight) {
        Class cell = NSClassFromString(self.cellType);
        CGFloat h = [tableView cellHeightForIndexPath:indexPath model:self.dataArray[indexPath.row] keyPath:@"model" cellClass:cell contentViewWidth:SCREEN_WIDTH];
        return h;
    } else {
        return self.y_rowheight == 0 ? 44.0 : self.y_rowheight;
    }
}

#pragma mark - empty delegate & datasource

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return (self.dataArray && self.dataArray.count == 0) ? YES : NO;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"此页面可能去火星旅游了!";
    UIFont *font = [UIFont systemFontOfSize:16];
    UIColor *textColor = [UIColor grayColor];
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = @"重新加载";
    UIFont *font = [UIFont systemFontOfSize:15];
    UIColor *textColor = [UIColor lightGrayColor];
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    
    if (self.tapEmptyReload) {
        self.tapEmptyReload();
    }
}

#pragma mark - refresh

- (void)headerRefresh:(BOOL)refresh {
    if (refresh) {
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
        self.cTableView.mj_header = header;
    }else {
        self.cTableView.mj_header = nil;
    }
}

- (void)footerRefresh:(BOOL)refresh {
    
    if (refresh) {
        MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [footer setTitle:@"上拉可以加载更多数据" forState:MJRefreshStateIdle];
        [footer setTitle:@"松开立即加载更多数据" forState:MJRefreshStatePulling];
        [footer setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
        self.cTableView.mj_footer = footer;
    }
}

- (void)loadNewData {
    
}

- (void)loadMoreData {
    
}

- (void)beginHeaderRefresh {
    if (![self.cTableView.mj_header isRefreshing]) {
        [self.cTableView.mj_header beginRefreshing];
    }
}

- (void)endRefresh {
    if ([self.cTableView.mj_header isRefreshing]) {
        [self.cTableView.mj_header endRefreshing];
    }
    if ([self.cTableView.mj_footer isRefreshing]) {
        [self.cTableView.mj_footer endRefreshing];
    }
}

#pragma mark - setter

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.cTableView reloadData];
}

- (void)setReuseIdentifier:(NSString *)reuseIdentifier {
    _reuseIdentifier = reuseIdentifier;
}

- (void)setAutoRowHeight:(BOOL)autoRowHeight {
    _autoRowHeight = autoRowHeight;
}

- (void)setY_rowheight:(CGFloat)y_rowheight {
    _y_rowheight = y_rowheight;
}

- (void)setIsSectionTable:(BOOL)isSectionTable {
    _isSectionTable = isSectionTable;
}

- (void)setIsLoadEmptyPage:(BOOL)isLoadEmptyPage {
    _isLoadEmptyPage = isLoadEmptyPage;
    if (!isLoadEmptyPage) {
        self.cTableView.emptyDataSetDelegate = nil;
        self.cTableView.emptyDataSetSource = nil;
    }
}



#pragma mark - lazy

- (UITableView *)cTableView {
    
    return C_LAZY(_cTableView, ({
        
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.tableFooterView = [UIView new];
        table;
    }));
}

@end
