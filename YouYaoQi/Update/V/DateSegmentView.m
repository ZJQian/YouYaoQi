//
//  DateSegmentView.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/4.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "DateSegmentView.h"
#import "NSCalendar+YExt.h"


@interface DateSegmentView ()

{
    UIImageView *_selectView;
}
@property (nonatomic, strong) NSMutableArray       *     weekArray;
@property (nonatomic, strong) NSMutableArray       *     btnArray;


@end

@implementation DateSegmentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat w = SCREEN_WIDTH/self.weekArray.count;

        UIImage *img = [UIImage imageNamed:@"today_selected_id_16x16_"];
        _selectView = [UIImageView new];
        _selectView.image = img;
        [self addSubview:_selectView];
        
        for (int i = 0; i < self.weekArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:self.weekArray[i] forState:UIControlStateNormal];
            btn.titleLabel.font = Y_Font(12);
            [btn setTitleColor:Color_theme forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.frame = CGRectMake(w*i, 0, w, frame.size.height-img.size.height);
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [self.btnArray addObject:btn];
            if (i == self.weekArray.count-1) {
                btn.selected = YES;
                _selectView.center = CGPointMake(btn.centerX, frame.size.height-img.size.height/2);
                _selectView.bounds = CGRectMake(0, 0, img.size.width, img.size.height);
            }
        }
        
    }
    return self;
}


- (void)scrollToIndex:(NSInteger)index {
    UIButton *btn = self.btnArray[index];
    __weak typeof(_selectView)weakSelectView = _selectView;
    [UIView animateWithDuration:0.3 animations:^{
        for (UIButton *b in self.btnArray) {
            b.selected = NO;
        }
        btn.selected = YES;
        weakSelectView.center = CGPointMake(btn.centerX, weakSelectView.centerY);
    }];
}

- (void)btnAction:(UIButton *)sender {
    NSInteger index = [self.btnArray indexOfObject:sender];
    [self scrollToIndex:index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(rollToIndex:)]) {
        [self.delegate rollToIndex:index];
    }
}

#pragma mark - lazy

- (NSMutableArray *)weekArray {
    if (!_weekArray) {
        switch ([NSCalendar currentWeekday]) {
            case 1:
                _weekArray = [NSMutableArray arrayWithArray:@[@"周二",@"周三",@"周四",@"周五",@"周六",@"昨天",@"今天"]];
                break;
            case 2:
                _weekArray = [NSMutableArray arrayWithArray:@[@"周三",@"周四",@"周五",@"周六",@"周日",@"昨天",@"今天"]];
                break;
            case 3:
                _weekArray = [NSMutableArray arrayWithArray:@[@"周四",@"周五",@"周六",@"周日",@"周一",@"昨天",@"今天"]];
                break;
            case 4:
                _weekArray = [NSMutableArray arrayWithArray:@[@"周五",@"周六",@"周日",@"周一",@"周二",@"昨天",@"今天"]];
                break;
            case 5:
                _weekArray = [NSMutableArray arrayWithArray:@[@"周六",@"周日",@"周一",@"周二",@"周三",@"昨天",@"今天"]];
                break;
            case 6:
                _weekArray = [NSMutableArray arrayWithArray:@[@"周日",@"周一",@"周二",@"周三",@"周四",@"昨天",@"今天"]];
                break;
            case 7:
                _weekArray = [NSMutableArray arrayWithArray:@[@"周一",@"周二",@"周三",@"周四",@"周五",@"昨天",@"今天"]];
                break;
            default:
                break;
        }
        
    }
    return _weekArray;
}

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

@end
