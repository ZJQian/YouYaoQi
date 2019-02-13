//
//  AttributeTouchLabel.h
//  YouYaoQi
//
//  Created by ZJQian on 2019/1/10.
//  Copyright © 2019 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^EventBlock)(NSAttributedString *aStr);

@interface AttributeTouchLabel : UIView


@property (nonatomic, copy) NSString         *           content;
@property (nonatomic, copy) EventBlock                   eventBlock;

@end

NS_ASSUME_NONNULL_END
