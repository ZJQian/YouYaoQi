//
//  RankViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/7.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "RankViewController.h"
#import "RankItemViewController.h"
#import "RankModel.h"


#define header_height  90

@interface RankViewController ()<UIScrollViewDelegate,UINavigationControllerDelegate>


@property (nonatomic, strong) UIScrollView      * bgScrollView;


@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
   
    self.navigationController.delegate = self;
    [CNetWorking getWithUrl:rankComicList params:@{@"page": @1} success:^(id  _Nonnull response) {
        NSMutableArray *tabArray = [NSMutableArray array];
        NSMutableArray *rankArray = [NSMutableArray array];
        tabArray = [RankTabModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"returnData"][@"rankTab"]];
        rankArray = [RankComicModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"returnData"][@"comics"]];
        //延迟0.5s是为了防止位置偏移的问题出现
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setSubControllers:tabArray rankArray:rankArray];
        });
    } failed:^(id  _Nonnull error) {
        
    }];
    
    
}
- (void)setSubControllers:(NSArray *)array rankArray:(NSArray *)rankArray {
    NSMutableArray *list = [NSMutableArray array];

    self.isCustomNav = YES;

    UIView *v = [UIView new];
    v.backgroundColor = [UIColor whiteColor];
    v.frame = CGRectMake(0, self.navView.height, SCREEN_WIDTH, header_height);
    [self.view addSubview:v];
    
    UILabel *lb = [UILabel new];
    lb.text = @"排行榜";
    lb.font = B_Font(23);
    [v addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
    }];
    
    for (int i = 0; i < array.count; i++) {
        RankTabModel *m = array[i];
        RankItemViewController *vc = [[RankItemViewController alloc] initWithReuseIdentifier:@"rankItemCell" cellType:@"RankTableViewCell"];
        vc.defaultRankArray = [NSMutableArray arrayWithArray:rankArray];
        vc.index = i;
        vc.rankTabModel = array[i];
        [self addChildViewController:vc];
        [list addObject:m.title];
    }
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:list];
    seg.tintColor = Color_theme;
    seg.selectedSegmentIndex = 0;
    [seg addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    [v addSubview:seg];
    [seg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lb);
        make.right.bottom.equalTo(@(-10));
        make.height.equalTo(@30);
    }];
    
    self.bgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*array.count, 0);
    [self scrollViewDidEndScrollingAnimation:self.bgScrollView];
}

- (void)segAction: (UISegmentedControl *)sender {
    [self.bgScrollView setContentOffset:CGPointMake(self.bgScrollView.width*sender.selectedSegmentIndex, self.bgScrollView.contentOffset.y) animated:YES];
}

#pragma mark - delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.bgScrollView) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.bgScrollView) {
        CGFloat offset_x = scrollView.contentOffset.x;
        int index = offset_x/SCREEN_WIDTH;
        RankItemViewController *vc = self.childViewControllers[index];
        if (vc.isViewLoaded) {return;}
        vc.view.frame = CGRectMake(offset_x, 0, SCREEN_WIDTH, scrollView.height);
        [scrollView addSubview:vc.view];
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isShow = [viewController isKindOfClass:[RankViewController class]];
    [navigationController setNavigationBarHidden:isShow animated:YES];
}

#pragma mark - lazy
- (UIScrollView *)bgScrollView {
    return C_LAZY(_bgScrollView, ({
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.height+header_height, SCREEN_WIDTH, SCREEN_HEIGHT-(self.navView.height+header_height))];
        scroll.delegate = self;
        scroll.pagingEnabled = YES;
        scroll.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:scroll];
        scroll;
    }));
}

@end
