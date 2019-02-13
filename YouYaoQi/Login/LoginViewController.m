//
//  LoginViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2019/1/10.
//  Copyright © 2019 zjq. All rights reserved.
//

#import "LoginViewController.h"
#import "AttributeTouchLabel.h"

@interface LoginViewController ()<UINavigationControllerDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.delegate = self;
    [self setSubViews];
}

- (void)setSubViews {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"closeee_26x26_"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(@(Status_Height+20));
        make.width.height.equalTo(@30);
    }];
    
    UIView *v_center = [[UIView alloc] init];
    v_center.bounds = CGRectMake(0, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT/2);
    v_center.center = self.view.center;
    v_center.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v_center];

    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, v_center.width, 30)];
    lb.text = @"登录/注册";
    lb.font = B_Font(25);
    [v_center addSubview:lb];
    
    UITextField *tf_phone = [[UITextField alloc] initWithFrame:CGRectMake(0, lb.bottom+35, v_center.width, 30)];
    tf_phone.placeholder = @"输入手机号";
    tf_phone.borderStyle = UITextBorderStyleNone;
    tf_phone.font = Y_Font(16);
    [v_center addSubview:tf_phone];

    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(-5, tf_phone.bottom+5, v_center.width+10, 1)];
    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    [v_center addSubview:line];
    
    
    UITextField *tf_num = [[UITextField alloc] initWithFrame:CGRectMake(0, line.bottom+35, v_center.width, 30)];
    tf_num.placeholder = @"输入验证码";
    tf_num.borderStyle = UITextBorderStyleNone;
    tf_num.font = Y_Font(16);
    [v_center addSubview:tf_num];
    
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(-5, tf_num.bottom+5, v_center.width+10, 1)];
    line2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    [v_center addSubview:line2];
    
    
    UIButton *btn_verify = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_verify.frame = CGRectMake(10, line2.bottom+35, v_center.width-20, (SCREEN_WIDTH*0.8-20)/333*46);
    [btn_verify setTitle:@"获取验证码" forState:UIControlStateNormal];
    btn_verify.titleLabel.font = Y_Font(15);
    [btn_verify setBackgroundImage:[UIImage imageNamed:@"loginBtnEnabledNo_333x46_"] forState:UIControlStateNormal];
    [v_center addSubview:btn_verify];
    
    
//    AttributeTouchLabel *aLb = [[AttributeTouchLabel alloc] initWithFrame:CGRectMake(25, btn_verify.bottom+30, v_center.width-50, 50)];
//    aLb.content = @"点击「获取验证码」按钮，代表您已阅读并同意《用户服务协议》，并注册手机验证后自动注册";
//    aLb.eventBlock = ^(NSAttributedString * _Nonnull aStr) {
//        DLog(@"%@",aStr);
//    };
//    [v_center addSubview:aLb];
    
    UIButton *btn_other = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_other setTitle:@"其他方式登录" forState:UIControlStateNormal];
    btn_other.titleLabel.font = Y_Font(15);
    [btn_other setTitleColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4] forState:UIControlStateNormal];
    [btn_other addTarget:self action:@selector(otherLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_other];
    [btn_other mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(@(-40));
    }];

}

- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)otherLoginAction {
    
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.9, 120)];
    contentView.backgroundColor = UIColorWhite;
    contentView.layer.cornerRadius = 6;
  
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:contentView.bounds];
    [contentView addSubview:scroll];
    
    NSArray *array = @[@{@"img":@"weibologin_50x50_",@"name":@"微博"},
                       @{@"img":@"wechatlogin_50x50_",@"name":@"微信"},
                       @{@"img":@"Smslogin_50x50_",@"name":@"短信"},
                       @{@"img":@"QQlogin_50x50_",@"name":@"QQ"},
                       @{@"img":@"shengda_50x50_",@"name":@"盛大"},
                       @{@"img":@"pwdlogin_50x50_",@"name":@"密码"}];
    scroll.contentSize = CGSizeMake(([UIImage imageNamed:array[0][@"img"]].size.width+30)*array.count+30, 0);
    for (int i = 0; i<array.count; i++) {
        UIImageView *img = [[UIImageView alloc] init];
        img.image = [UIImage imageNamed:array[i][@"img"]];
        [scroll addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(scroll).offset(-10);
            make.left.equalTo(@((img.image.size.width+30)*i+30));
        }];
        
        UILabel *lb = [UILabel new];
        lb.textColor = Color_Title;
        lb.text = array[i][@"name"];
        lb.textAlignment = NSTextAlignmentCenter;
        [scroll addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(img);
            make.top.equalTo(img.mas_bottom).offset(10);
        }];
    }
    
//    UIEdgeInsets contentViewPadding = UIEdgeInsetsMake(20, 20, 20, 20);
//    label.frame = CGRectMake(contentViewPadding.left, contentViewPadding.top, CGRectGetWidth(contentView.bounds) - UIEdgeInsetsGetHorizontalValue(contentViewPadding), QMUIViewSelfSizingHeight);
//
//    contentView.contentSize = CGSizeMake(CGRectGetWidth(contentView.bounds), CGRectGetMaxY(label.frame) + contentViewPadding.bottom);
    
    QMUIModalPresentationViewController *modalViewController = [[QMUIModalPresentationViewController alloc] init];
    modalViewController.contentView = contentView;
    modalViewController.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
        contentView.frame = CGRectSetXY(contentView.frame, CGFloatGetCenter(CGRectGetWidth(containerBounds), CGRectGetWidth(contentView.frame)), CGRectGetHeight(containerBounds) - 20 - CGRectGetHeight(contentView.frame));
    };
    modalViewController.showingAnimation = ^(UIView *dimmingView, CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewFrame, void(^completion)(BOOL finished)) {
        contentView.frame = CGRectSetY(contentView.frame, CGRectGetHeight(containerBounds));
        dimmingView.alpha = 0;
        [UIView animateWithDuration:.25 delay:0.0 options:QMUIViewAnimationOptionsCurveIn animations:^{
            dimmingView.alpha = 1;
            contentView.frame = contentViewFrame;
        } completion:^(BOOL finished) {
            // 记住一定要在适当的时机调用completion()
            if (completion) {
                completion(finished);
            }
        }];
    };
    modalViewController.hidingAnimation = ^(UIView *dimmingView, CGRect containerBounds, CGFloat keyboardHeight, void(^completion)(BOOL finished)) {
        [UIView animateWithDuration:.25 delay:0.0 options:QMUIViewAnimationOptionsCurveOut animations:^{
            dimmingView.alpha = 0.0;
            contentView.frame = CGRectSetY(contentView.frame, CGRectGetHeight(containerBounds));
        } completion:^(BOOL finished) {
            // 记住一定要在适当的时机调用completion()
            if (completion) {
                completion(finished);
            }
        }];
    };
    [modalViewController showWithAnimated:YES completion:nil];
}

#pragma mark - delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isShow = [viewController isKindOfClass:[LoginViewController class]];
    [navigationController setNavigationBarHidden:isShow animated:YES];
}

@end
