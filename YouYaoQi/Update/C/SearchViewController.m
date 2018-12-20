//
//  SearchViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/18.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UINavigationControllerDelegate>

@end

@implementation SearchViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setSubviews];
}

- (void)setSubviews {
    
    UIView *v_nav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Nav_Custom_Height)];
    v_nav.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v_nav];
    
    UIView *v_tf = [UIView new];
    [v_tf setConerRadius:15];
    v_tf.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    [v_nav addSubview:v_tf];
    [v_tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@(Status_Height+5));
        make.bottom.equalTo(@(-5));
        make.right.equalTo(@(-65));
    }];
    
    UITextField *tf = [[UITextField alloc] init];
    tf.font = Y_Font(14);
    tf.borderStyle = UITextBorderStyleNone;
    [v_tf addSubview:tf];
    [tf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.top.equalTo(@2);
        make.bottom.equalTo(@(-2));
    }];
    
    UIButton *btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_cancel setTitle:@"取消" forState:UIControlStateNormal];
    [btn_cancel setTitleColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
    [btn_cancel addTarget:self action:@selector(btnCancelAction) forControlEvents:UIControlEventTouchUpInside];
    btn_cancel.titleLabel.font = Y_Font(14);
    [v_nav addSubview:btn_cancel];
    [btn_cancel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(v_tf.mas_right).offset(10);
        make.right.equalTo(v_nav);
        make.centerY.height.equalTo(v_tf);
    }];
    
    
    
}

- (void)btnCancelAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isShow = [viewController isKindOfClass:[SearchViewController class]];
    [navigationController setNavigationBarHidden:isShow animated:YES];
}


@end
