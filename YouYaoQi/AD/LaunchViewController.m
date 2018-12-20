//
//  LaunchViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/14.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "LaunchViewController.h"
#import "CBaseTabBarController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scroll];
    scroll.contentSize = CGSizeMake(SCREEN_WIDTH*3, scroll.height);
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*3, SCREEN_HEIGHT)];
    img.image = [UIImage imageNamed:@"start_guide_page"];
    [img setUserInteractionEnabled:YES];
    [scroll addSubview:img];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.center = CGPointMake(SCREEN_WIDTH*2+SCREEN_WIDTH/2, SCREEN_HEIGHT*0.87);
    btn.bounds = CGRectMake(0, 0, SCREEN_WIDTH/3, 50);
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    [img addSubview:btn];
    
}

- (void)btnAction {
    [DefaultsUtil saveFirstIn];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.window.rootViewController = [CBaseTabBarController new];
}


@end
