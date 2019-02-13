//
//  SettingViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/13.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>


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
    [self.view addSubview:self.settingTableView];

    
}


#pragma mark - delegate



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellID = @"settingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.font = Y_Font(15);
    cell.textLabel.textColor = Color_Title;
    if ((indexPath.section == 0 || indexPath.section == 2) && indexPath.row == 0) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"june_pay_right_13x13_"]];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        cell.accessoryView = nil;
    }else if (indexPath.section == 2 && indexPath.row == 1) {
        cell.accessoryView = nil;
    }else {
        UISwitch *swi = [[UISwitch alloc] init];
        swi.onTintColor = Color_theme;
        [swi setOn:YES];
        cell.accessoryView = swi;
    }
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
        NSMutableArray *array = [NSMutableArray arrayWithArray:@[@[@"账户与安全",@"漫画更新提醒",@"清除缓存"],
                                                                 @[@"WiFi自动下载",@"网络环境提示",@"手机网络下载",@"开启阅读预览图",@"自动更换节日皮肤"],
                                                                 @[@"给我们评分",@"关于我们"]]];
        array;
    }));
}




@end
