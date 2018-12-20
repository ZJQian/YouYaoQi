//
//  CBaseViewController.h
//  OC_Cloud
//
//  Created by ZJQian on 2018/11/27.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavBarView.h"
@interface CBaseViewController : UIViewController



/**
 是否使用自定义的导航栏
 */
@property (nonatomic, assign) BOOL                     isCustomNav;
@property (nonatomic, strong) NavBarView         *     navView;


@end

