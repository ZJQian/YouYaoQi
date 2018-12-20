//
//  NSCalendar+YExt.m
//  YouYaoQi
//
//  Created by ZJQian on 2018/12/4.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "NSCalendar+YExt.h"

@implementation NSCalendar (YExt)

+ (NSInteger)currentWeekday {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSInteger weekday = [comps weekday];
    if (weekday == 7) {
        return 6;
    }else if (weekday == 6){
        return 5;
    }else if (weekday == 5){
        return 4;
    }else if (weekday == 4){
        return 3;
    }else if (weekday == 3){
        return 2;
    }else if (weekday == 2){
        return 1;
    }else {
        return 7;
    }
}


@end
