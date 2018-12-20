//
//  MoreViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/10.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreModel.h"
#import "BannerItemModel.h"
#import "MoreTableViewCell.h"


@interface MoreViewController ()<UINavigationControllerDelegate>


@property(nonatomic, strong) UIImageView         *            headImgView;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationController.delegate = self;
    self.cTableView.frame = CGRectMake(0, self.headImgView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.headImgView.bottom);
    self.cTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.cTableView.backgroundColor = [UIColor whiteColor];
    self.cTableView.showsVerticalScrollIndicator = NO;
    self.autoRowHeight = YES;
    [self.view addSubview:self.cTableView];
    
    self.isCustomNav = YES;
    self.navView.backgroundColor = [UIColor clearColor];
    
    
    __weak typeof(self)weakSelf = self;
    self.cellConfig = ^(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath, id  _Nonnull cell) {
        
        MoreModel *model = weakSelf.dataArray[indexPath.row];
        MoreTableViewCell *c = cell;
        c.model = model;
    };
    [self headerRefresh:YES];
    [self beginHeaderRefresh];

}

- (void)loadNewData {
    
    [CNetWorking getWithUrl:commonComicList params:@{@"argCon":@0,@"argName":self.model.argName,@"argValue":self.model.argValue,@"page":@1,@"sexType":@3} success:^(id  _Nonnull response) {
        self.dataArray = [MoreModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"returnData"][@"comics"]];
        [self endRefresh];
    } failed:^(id  _Nonnull error) {
        [self endRefresh];
    }];
}



- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isShow = [viewController isKindOfClass:[MoreViewController class]];
    [navigationController setNavigationBarHidden:isShow animated:YES];
}


- (UIImageView *)headImgView {
    return C_LAZY(_headImgView, ({
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*250/621)];
        img.image = [UIImage imageNamed:@"moreHead_621x250_"];
        [self.view addSubview: img];
        UILabel *lb = [[UILabel alloc] init];
        lb.text = self.model.itemTitle;
        lb.font = B_Font(22);
        [img addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.centerY.equalTo(@20);
        }];
        img;
    }));
}

@end
