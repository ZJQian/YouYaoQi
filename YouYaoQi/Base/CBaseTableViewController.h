//
//  CBaseTableViewController.h
//  OC_Cloud
//
//  Created by ZJQian on 2018/11/30.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "CBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^CellConfig)(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath, id cell);
typedef NSInteger(^CellCountConfig)(UITableView * _Nonnull table,NSInteger section);
typedef void(^DidSelectCellConfig)(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath);
typedef void(^TapEmptyReload)(void);

@interface CBaseTableViewController : CBaseViewController



@property (nonatomic, strong) UITableView         *           cTableView;


/**
 标识符
 */
@property (nonatomic, copy) NSString         *           reuseIdentifier;


/**
 cell类型
 */
@property (nonatomic, copy) NSString         *           cellType;


/**
 数据源
 */
@property (nonatomic, copy) NSArray         *           dataArray;



/**
 是否是分组
 */
@property (nonatomic, assign) BOOL                     isSectionTable;



/**
 是否自适应行高
 */
@property (nonatomic, assign) BOOL                     autoRowHeight;


/**
 行高
 */
@property (nonatomic, assign) CGFloat                     y_rowheight;

/**
 是否加载 空数据/错误数据 页面
 */
@property (nonatomic, assign) BOOL                         isLoadEmptyPage;


@property (nonatomic, copy) CellConfig                       cellConfig;
@property (nonatomic, copy) CellCountConfig                  cellCountConfig;
@property (nonatomic, copy) DidSelectCellConfig              didSelectCellConfig;
@property (nonatomic, copy) TapEmptyReload                   tapEmptyReload;

/**
 构造方法
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier cellType:(NSString *)cellType;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier dataArray:(NSMutableArray *)dataArray;


/**
 下拉刷新
 */
- (void)headerRefresh:(BOOL)refresh;
- (void)loadNewData;
- (void)beginHeaderRefresh;


/**
 上拉加载
 */
- (void)footerRefresh:(BOOL)refresh;
- (void)loadMoreData;


/**
 停止刷新
 */
- (void)endRefresh;

@end

NS_ASSUME_NONNULL_END
