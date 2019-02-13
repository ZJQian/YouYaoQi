//
//  AttributeTouchLabel.m
//  YouYaoQi
//
//  Created by ZJQian on 2019/1/10.
//  Copyright © 2019 zjq. All rights reserved.
//

#import "AttributeTouchLabel.h"

@interface AttributeTouchLabel ()<UITextViewDelegate>

{
    UITextView   *  _textView;
}

@end
@implementation AttributeTouchLabel

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        _textView = [[UITextView alloc]initWithFrame:self.bounds];
        _textView.delegate = self;
        _textView.editable = NO;//必须禁止输入，否则点击将会弹出输入键盘
        _textView.scrollEnabled = NO;//可选的，视具体情况而定
        _textView.font = Y_Font(20);
        _textView.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
        [self addSubview:_textView];
    }
    return self;
    
}

- (void)setContent:(NSString *)content {
    
    _content = content;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:content];
    
    [attStr addAttributes:@{NSForegroundColorAttributeName: [UIColor redColor],NSLinkAttributeName: @"click://"} range:NSRangeFromString(@"《用户服务协议》")];
    
    _textView.attributedText = attStr;
    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    
    if ([[URL scheme] containsString:@"click"]) {
        NSAttributedString *abStr = [textView.attributedText attributedSubstringFromRange:characterRange];
        if (self.eventBlock) {
            self.eventBlock(abStr);
        }
        return NO;
    }
    return YES;
}



@end
