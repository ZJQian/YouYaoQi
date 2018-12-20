//
//  AuthorViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/18.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "AuthorViewController.h"

@interface AuthorViewController ()<UINavigationControllerDelegate>

@end

@implementation AuthorViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isCustomNav = YES;
    self.navView.lb_left.text = @"我的";
    self.navView.lb_navTitle.text = @"作者中心";
    
    self.cTableView.frame = CGRectMake(0, Nav_Custom_Height, SCREEN_WIDTH, SCREEN_HEIGHT-Nav_Custom_Height);
    [self.view addSubview:self.cTableView];
    self.dataArray = @[@"成为作者"];
    __weak typeof(self)weakSelf = self;
    self.cellConfig = ^(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath, id  _Nonnull cell) {
        UITableViewCell *c = cell;
        c.imageView.image = [UIImage imageNamed:@"sep_be_author_21x21_"];
        c.textLabel.font = Y_Font(15);
        c.textLabel.text = weakSelf.dataArray[indexPath.row];
    };
    
}
#pragma mark - delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isShow = [viewController isKindOfClass:[AuthorViewController class]];
    [navigationController setNavigationBarHidden:isShow animated:YES];
}

@end
