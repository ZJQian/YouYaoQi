//
//  SettingViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/13.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView      *           settingTableView;
@property (nonatomic, strong) NSMutableArray      *           dataArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isCustomNav = YES;
    self.navView.lb_left.text = @"我的";
    self.navView.lb_navTitle.text = @"设置";
    self.navigationController.delegate = self;
    [self.view addSubview:self.settingTableView];

    
}


#pragma mark - delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isShow = [viewController isKindOfClass:[SettingViewController class]];
    [navigationController setNavigationBarHidden:isShow animated:YES];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellID = @"settingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor clearColor];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark - lazy
- (UITableView *)settingTableView {
    return C_LAZY(_settingTableView, ({
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, Nav_Custom_Height, SCREEN_WIDTH, SCREEN_HEIGHT-Nav_Custom_Height) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.tableFooterView = [UIView new];
        table.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
        table;
    }));
}

- (NSMutableArray *)dataArray {
    return C_LAZY(_dataArray, ({
        NSMutableArray *array = [NSMutableArray arrayWithArray:@[@[@"账户与安全",@"漫画更新提醒",@"清楚缓存"],
                                                                 @[@"WiFi自动下载",@"网络环境提示",@"手机网络下载",@"开启阅读预览图",@"自动更换节日皮肤"],
                                                                 @[@"给我们评分",@"关于我们"]]];
        array;
    }));
}




@end
