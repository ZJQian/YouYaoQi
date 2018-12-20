//
//  AdView.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/13.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "AdView.h"
#import "ADModel.h"
#import <SDWebImage/SDWebImageManager.h>


static NSInteger showTime = 3;


@interface AdView ()


@property (nonatomic, strong) UIImageView         *          img_backView;
@property (nonatomic, strong) UILabel             *          lb_time;
@property (nonatomic, strong) dispatch_source_t              timer;

@end

@implementation AdView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        
        [self addSubview:self.img_backView];
        [self.img_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self addSubview:self.lb_time];
        [self.lb_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-20));
            make.top.equalTo(@40);
            make.width.equalTo(@50);
            make.height.equalTo(@26);
        }];
        
        [self showAd];
        [self downAd];
        [self startTimer];
    }
    return self;
}


- (void)showAd {
    
    
    NSString * filePath = [DefaultsUtil getAdvertise];
    
    UIImage * lastCacheImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:filePath];
    if (lastCacheImage) {
        self.img_backView.image = lastCacheImage;
    } else {
        self.hidden = YES;
    }
    
}

- (void)downAd {
    
    //获取最新广告数据
    [CNetWorking getWithUrl:launcher success:^(id  _Nonnull response) {
        
        ADModel *model = [ADModel mj_objectWithKeyValues:response[@"data"][@"returnData"][@"startAd"]];
        NSURL * imageUrl = [NSURL URLWithString: model.image_url];
        //SDWebImageAvoidAutoSetImage 下载完不给imageView赋值
        [[SDWebImageManager sharedManager] loadImageWithURL:imageUrl options:SDWebImageAvoidAutoSetImage progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            DLog(@"下载成功");
            [DefaultsUtil setAdvertise:model.image_url];
        }];
        
    } failed:^(id  _Nonnull error) {
        
    }];
}

- (void)startTimer {
    
    __block NSUInteger timeout = showTime + 1;
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    
    self.timer = timer;
    
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (timeout <= 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dissmiss];
            });
            
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"跳过 %zd",timeout]];
                [str setAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} range:NSMakeRange(0, 3)];
                self.lb_time.attributedText = str;
            });
            
            timeout-- ;
            
        }
    });
    dispatch_resume(timer);
}

- (void)dissmiss {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        
        [self removeFromSuperview];
    }];
}



- (UIImageView *)img_backView {
    return C_LAZY(_img_backView, ({
        UIImageView *img = [UIImageView new];
        img;
    }));
}

- (UILabel *)lb_time {
    return C_LAZY(_lb_time, ({
        UILabel *lb = [UILabel new];
        lb.font = Y_Font(13);
        lb.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [lb setConerRadius:13];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = Color_theme;
        lb;
    }));
}

@end
