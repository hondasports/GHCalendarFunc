//
//  CalendarFunc.m
//  calendarFunc
//
//  Created by MIYAMOTO TATSUYA on 2012/12/18.
//  Copyright (c) 2012年 MIYAMOTO TATSUYA. All rights reserved.
//

#import "CalendarFunc.h"

@implementation CalendarFunc

- (id)init {
    self = [super init];
    if (self) {
        _calendar = [NSCalendar currentCalendar];
        _defaultCalendarUnit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    }
    return self;
}

// 指定月の日数を取得
- (NSInteger)numberOfMonth {
    NSInteger leng = [_calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self.selectedDate].length;
    return leng;
}

// 指定月の1日以前の日数を取得
- (NSInteger)beforeNumberOfFirstDay {
    NSDateComponents *dc = [self _dateComponents:1];
    return [dc weekday] - 1;
}

// 描画に必要なCellの数を取得
- (NSArray *)numberOfCell {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObjectsFromArray:self.beforeFirstDayWeekdays];
    [array addObjectsFromArray:[self daysOfMonthObjects]];
    [array addObjectsFromArray:self.afterEndOfDayWeekdays];
    return array;
}

// 指定日でDateComponentsを生成
- (NSDateComponents *)_dateComponents:(int)day {
    NSDateComponents *dc = [self _dateComponents];
    [dc setDay:day];
    NSDate *modifiedDate = [_calendar dateFromComponents:dc];
    return [_calendar components:_defaultCalendarUnit fromDate:modifiedDate];
}

- (NSDateComponents *)_dateComponents {
    return [_calendar components:_defaultCalendarUnit fromDate:self.selectedDate];
}

- (NSInteger)currentMonth {
    return [[self _dateComponents] month];
}

- (NSInteger)currentYear {
    return [[self _dateComponents] year];
}

// 指定月の1日以前の日付のリスト取得
- (NSArray *)beforeFirstDayWeekdays {
    NSDateComponents *dc = [self _dateComponents:1];
    int beforeDays = [dc weekday];
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:beforeDays];

    // 0日前で指定すると前日が取得できたため、
    // 開始を1始まりで終了を1減らした数値でループ
    for (int i = 0; i < (beforeDays - 1); i++) {
        int minusValue = i - i - i;
        NSDateComponents *dc = [self _dateComponents:minusValue];
        NSNumber *day = [NSNumber numberWithInt:[dc day]];

        [list addObject:day];
    }

    NSMutableArray *reversedList = [NSMutableArray arrayWithCapacity:[list count]];
    NSEnumerator *enumerator = [list reverseObjectEnumerator];
    for (id elem in enumerator) {
        [reversedList addObject:elem];
    }
    return reversedList;
}

// 指定月の最終日以降の日付のリスト取得
- (NSArray *)afterEndOfDayWeekdays {
    int dateRange = [_calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self.selectedDate].length;
    NSDateComponents *dc = [self _dateComponents:dateRange];

    int weekDays = 7 - [dc weekday];
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:weekDays];

    for (int i = 1; i <= weekDays; i++) {
        NSDateComponents *dc = [self _dateComponents:i];
        NSNumber *day = [NSNumber numberWithInt:[dc day]];

        [list addObject:day];
    }
    return list;
}

// ロケールに合わせた曜日のリストを返す
- (NSArray *)weekdaySymbols {
    return [self.currentDateFormatter shortWeekdaySymbols];
}

// ロケールに合わせた月のリストを返す
- (NSArray *)monthSymbols {
    return [self.currentDateFormatter shortMonthSymbols];
}

- (NSDateFormatter *)currentDateFormatter {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    return formatter;
}

// 次月の１日と最終日のepochTimeを取得
- (NSDictionary *)incrementMonth {
    NSDateComponents *dc = [self _dateComponents];

    NSInteger month = [dc month];
    month++;

    return [self _updateDateByMonth:month dateComponent:dc];
}

// 前月の１日と最終日のEpochTimeを取得
- (NSDictionary *)decrementMonth {
    NSDateComponents *dc = [self _dateComponents];

    NSInteger month = [dc month];
    month--;
    return [self _updateDateByMonth:month dateComponent:dc];
}

// 指定された月の１日と最終日のEpochtimeを返し、selectedDateを更新する
- (NSDictionary *)_updateDateByMonth:(NSInteger)month dateComponent:(NSDateComponents *)dc {
    NSMutableDictionary *startEndDictionary = [NSMutableDictionary dictionary];

    [dc setMonth:month];
    [dc setDay:1];
    NSDate *startDate = [_calendar dateFromComponents:dc];
    [startEndDictionary setObject:[NSNumber numberWithDouble:[startDate timeIntervalSince1970]] forKey:@"startEpochtime"];

    [self setSelectedDate:startDate];

    [dc setDay:[self numberOfMonth]];
    [dc setHour:23];
    [dc setMinute:59];
    [dc setSecond:59];
    NSDate *endDate = [_calendar dateFromComponents:dc];
    [startEndDictionary setObject:[NSNumber numberWithDouble:[endDate timeIntervalSince1970]] forKey:@"endEpochtime"];

    return startEndDictionary;
}

// 現在の月のエポックタイムを取得する
- (NSDictionary *)currentEpochtimes {
    NSDateComponents *dc = [self _dateComponents];
    NSInteger month = [dc month];

    return [self _updateDateByMonth:month dateComponent:dc];
}

// FQLのTIME型をNSDateComponentに変換する
- (NSDateComponents *)epoch2DateComponent:(NSString *)dateString {

    return [_calendar components:_defaultCalendarUnit
                        fromDate:[[NSDate alloc] initWithTimeIntervalSince1970:[dateString doubleValue]]];


}

// 月の日のリストを取得する
- (NSArray *)daysOfMonthObjects {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int index = 0; index < self.numberOfMonth; index++) {
        [array addObject:[NSNumber numberWithInt:(index + 1)]];
    }
    return array;
}
@end