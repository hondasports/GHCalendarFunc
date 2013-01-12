//
//  CalendarFunc.m
//  calendarFunc
//
//  Created by MIYAMOTO TATSUYA on 2012/12/18.
//  Copyright (c) 2012年 MIYAMOTO TATSUYA. All rights reserved.
//

#import "CalendarFunc.h"

@implementation CalendarFunc

@synthesize selectedDate            = _selectedDate;
@synthesize beforeFirstDayWeekdays  = _beforeFirstDayWeekdays;
@synthesize afterEndOfDayWeekdays   = _afterEndOfDayWeekdays;
@synthesize weekdaySymbols          = _weekdaySymbols;
@synthesize monthSymbols            = _monthSymbols;
@synthesize startEndEpochtime       = _startEndEpochtime;

@synthesize numberOfMonth;
@synthesize numberOfCell            = _numberOfCell;
@synthesize currentMonth;

-(id) init{
    self = [super init];
    if(self){
        _calendar = [NSCalendar currentCalendar];
        _defaultCalendarUnit = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit| NSWeekdayCalendarUnit;
    }
    return self;
}

// 指定月の日数を取得
-(NSInteger) numberOfMonth{ 
    NSInteger leng = [_calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self.selectedDate].length;
    return leng;
}

// 指定月の1日以前の日数を取得
-(NSInteger) beforeNumberOfFirstDay{
    NSDateComponents* dc = [self dateComponents:1];
    return [dc weekday]-1;
}

// 描画に必要なCellの数を取得
-(NSArray *) numberOfCell{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    [array addObjectsFromArray:self.beforeFirstDayWeekdays];
    for (int index=0; index<self.numberOfMonth; index++) {
        [array addObject:[NSNumber numberWithInt:(index+1)]];
    }
    [array addObjectsFromArray:self.afterEndOfDayWeekdays];
    return array;
}

// 指定日でDateComponentsを生成
-(NSDateComponents *) dateComponents:(int)day{
    NSDateComponents* dc = [_calendar components:_defaultCalendarUnit fromDate:self.selectedDate];
    [dc setDay:day];
    NSDate* modifiedDate = [_calendar dateFromComponents:dc];
    return [_calendar components:_defaultCalendarUnit fromDate:modifiedDate];
}

-(NSInteger) currentMonth{
    NSDateComponents* dc = [ _calendar components:_defaultCalendarUnit fromDate:self.selectedDate];
    return [dc month];
}

// 指定月の1日以前の日付のリストを取得
-(NSArray *) beforeFirstDayWeekdays {
    NSDateComponents* dc = [self dateComponents:1];
    int beforeDays = [dc weekday];
    NSMutableArray* list = [NSMutableArray arrayWithCapacity:beforeDays];
    
    // 0日前で指定すると前日が取得できたため、
    // 開始を1始まりで終了を1減らした数値でループ
    for (int i=0; i<(beforeDays-1); i++) {
        int minusValue = i - i - i;
        NSDateComponents* dc = [self dateComponents:minusValue];
        NSNumber* day = [NSNumber numberWithInt:[dc day]];

        [list addObject:day];
    }

    NSMutableArray* reversedList = [NSMutableArray arrayWithCapacity:[list count]];
    NSEnumerator* enumerator = [list reverseObjectEnumerator];
    for (id elem in enumerator) {
        [reversedList addObject:elem];
    }
    return reversedList;
}

// 指定月の最終日以降の日数を取得
-(NSArray *) afterEndOfDayWeekdays{
    int dateRange = [_calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self.selectedDate].length;
    NSDateComponents* dc = [self dateComponents:dateRange];
    
    int weekDays = 7-[dc weekday];
    NSMutableArray* list = [NSMutableArray arrayWithCapacity:weekDays];

    for (int i=1; i<=weekDays ; i++){
        NSDateComponents* dc = [self dateComponents:i];
        NSNumber* day = [NSNumber numberWithInt:[dc day]];

        [list addObject:day];
    }
    return list;
}

-(NSArray *) weekdaySymbols{
    return [self.currentDateFormatter shortWeekdaySymbols];
}

-(NSArray *) monthSymbols{
    return [self.currentDateFormatter shortMonthSymbols];
}

-(NSDateFormatter *) currentDateFormatter {

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    return formatter;
}

-(NSDictionary *) startEndEpochtime{

    NSDateComponents* dc = [_calendar components:_defaultCalendarUnit fromDate:self.selectedDate];
    [dc setMonth:0];
    [dc setDay:1];
    NSDate* startDate = [_calendar dateFromComponents:dc];
    NSMutableDictionary* startEndDictionary = [NSMutableDictionary dictionary];
    [startEndDictionary setObject:[NSNumber numberWithDouble:[startDate timeIntervalSince1970]] forKey:@"startEpochtime"];

    return startEndDictionary;
}

@end