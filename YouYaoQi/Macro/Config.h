//
//  Config.h
//  OC_Cloud
//
//  Created by ZJQian on 2018/11/27.
//  Copyright © 2018 zjq. All rights reserved.
//

#ifndef Config_h
#define Config_h


// 懒加载
#define C_LAZY(object, assignment) (object = object ?: assignment)

// 设置颜色
#define rgb(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define rgba(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define hexColor(colorValue) [UIColor colorWithHexString:colorValue alpha:1.0f]
#define hexColorAlpha(colorValue,a) [UIColor colorWithHexString:colorValue alpha:(a)]


#define Color_theme  hexColor(@"2cdd8f")



// 设置字体
#define C_Font(fontName,font)    [UIFont fontWithName:(fontName) size:(font)]
#define Y_Font(font)    [UIFont systemFontOfSize:font]
#define B_Font(font)    [UIFont boldSystemFontOfSize:font]

// 获取屏幕宽度，高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define IS_IPHONEX (([[UIScreen mainScreen] bounds].size.height-812)?NO:YES)
#define Y_Height (IS_IPHONEX ? ([[UIScreen mainScreen] bounds].size.height-20):([[UIScreen mainScreen] bounds].size.height))
#define Status_Height (IS_IPHONEX ? 44.0 : 20.0)
#define Nav_Height (IS_IPHONEX ? 88.0 : 64.0)
#define Nav_Custom_Height (IS_IPHONEX ? 84.0 : 60.0)
#define MainScreenRect       [UIScreen mainScreen].bounds

#define C_APPDelegate  ((AppDelegate*)[UIApplication sharedApplication].delegate)

// debug下打印，release下不打印
#ifdef DEBUG // 调试状态, 打开LOG功能

#define DLog( s, ... ) printf("method: %s %s\n", __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String] )

#else// 发布状态, 关闭LOG功能
#define DLog( s, ... )
#endif



#endif /* Config_h */
