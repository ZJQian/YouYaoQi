//
//  UpdateViewController.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/3.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "UpdateViewController.h"
#import "UpdateItemViewController.h"
#import "DateSegmentView.h"
#import "NSCalendar+YExt.h"


@interface UpdateViewController ()<UIScrollViewDelegate,DateSegmentViewDelegate>

@property (nonatomic, strong) DateSegmentView   * dateSegmentView;
@property (nonatomic, strong) UIScrollView      * bgScrollView;
@property (nonatomic, strong) NSMutableArray    * weekArray;


@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.dateSegmentView];
    
    for (int i = 0; i < 7; i++) {
        UpdateItemViewController *vc = [[UpdateItemViewController alloc] initWithReuseIdentifier:@"updateItemCell" cellType:@"UpdateItemCell"];
        vc.weekday = self.weekArray[i];
        [self addChildViewController:vc];
    }
    self.bgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*7, 0);
    [self.bgScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*6, self.bgScrollView.contentOffset.y) animated:YES];
    [self scrollViewDidEndScrollingAnimation:self.bgScrollView];

}

#pragma mark - delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.bgScrollView) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.bgScrollView) {
        CGFloat offset_x = scrollView.contentOffset.x;
        int index = offset_x/SCREEN_WIDTH;
        [self.dateSegmentView scrollToIndex:index];
        UpdateItemViewController *vc = self.childViewControllers[index];
        if (vc.isViewLoaded) {return;}
        vc.view.frame = CGRectMake(offset_x, 0, SCREEN_WIDTH, scrollView.height);
        [scrollView addSubview:vc.view];
    }
}

- (void)rollToIndex:(NSInteger)index {
    [self.bgScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, self.bgScrollView.contentOffset.y) animated:YES];
}

#pragma mark - lazy


- (DateSegmentView *)dateSegmentView {
    return C_LAZY(_dateSegmentView, ({
        DateSegmentView *seg = [[DateSegmentView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
        seg.delegate = self;
        seg;
    }));
}

- (UIScrollView *)bgScrollView {
    return C_LAZY(_bgScrollView, ({
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.dateSegmentView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-self.dateSegmentView.bottom)];
        scroll.delegate = self;
        scroll.pagingEnabled = YES;
        scroll.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:scroll];
        scroll;
    }));
}
- (NSMutableArray *)weekArray {
    if (!_weekArray) {
        switch ([NSCalendar currentWeekday]) {
            case 1:
                _weekArray = [NSMutableArray arrayWithArray:@[@2,@3,@4,@5,@6,@7,@1]];
                break;
            case 2:
                _weekArray = [NSMutableArray arrayWithArray:@[@3,@4,@5,@6,@7,@1,@2]];
                break;
            case 3:
                _weekArray = [NSMutableArray arrayWithArray:@[@4,@5,@6,@7,@1,@2,@3]];
                break;
            case 4:
                _weekArray = [NSMutableArray arrayWithArray:@[@5,@6,@7,@1,@2,@3,@4]];
                break;
            case 5:
                _weekArray = [NSMutableArray arrayWithArray:@[@6,@7,@1,@2,@3,@4,@5]];
                break;
            case 6:
                _weekArray = [NSMutableArray arrayWithArray:@[@7,@1,@2,@3,@4,@5,@6]];
                break;
            case 7:
                _weekArray = [NSMutableArray arrayWithArray:@[@1,@2,@3,@4,@5,@6,@7]];
                break;
            default:
                break;
        }
        
    }
    return _weekArray;
}

@end
