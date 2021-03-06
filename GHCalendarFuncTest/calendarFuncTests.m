//
//  calendarFuncTests.m
//  calendarFuncTests
//
//  Created by MIYAMOTO TATSUYA on 2012/12/18.
//  Copyright (c) 2012年 MIYAMOTO TATSUYA. All rights reserved.
//

#import "calendarFuncTests.h"

@implementation calendarFuncTests

- (void)setUp {
    [super setUp];

    // Set-up code here.
    calendarFunc = [[CalendarFunc alloc] init];
    [calendarFunc setSelectedDate:[NSDate date]];
}

- (void)tearDown {
    // Tear-down code here.

    [super tearDown];
}

- (void)testNumberOfMonth {
    NSInteger numberOfMonth = [calendarFunc numberOfMonth];
    GHAssertEquals(numberOfMonth, 31, @"日子の指定が正しくありません");
}

- (void)testNumberOfCell {
//    NSInteger numberOfCell = [calendarFunc numberOfCell];
    NSArray *allDays = [calendarFunc numberOfCell];
    NSInteger count = [allDays count];

    GHAssertEquals(count, 42, @"セルの数が正しくありません");
}

- (void)testCurrentMonth {
    NSInteger currentMonth = [calendarFunc currentMonth];
    GHAssertEquals(currentMonth, 3, @"指定された月が正しくありません");
}

/*
 1日以前の日数と、1日の属する週の日のリストを取得する
 */
- (void)testBeforeWeekdays {
    NSArray *weekDays = [calendarFunc beforeFirstDayWeekdays];
    NSInteger count = [weekDays count];
    GHAssertEquals(count, 5, @"1日以前の日数の指定が正しくありません");

    int day = [[weekDays objectAtIndex:0] intValue];
    GHAssertEquals(day, 24, @"日の指定が正しくありません");

    day = [[weekDays objectAtIndex:1] intValue];
    GHAssertEquals(day, 25, @"日の指定が正しくありません");
}

/*
 月の最終日以降の日数と、その日を取得する為のテスト
 */
- (void)testAfterWeekdays {
    NSArray *weekDays = [calendarFunc afterEndOfDayWeekdays];
    NSInteger count = [weekDays count];
    GHAssertEquals(count, 6, @"最終日以降の日数の指定が正しくありません");

    int day = [[weekDays objectAtIndex:0] intValue];
    GHAssertEquals(day, 1, @"日の指定が正しくありません");

    day = [[weekDays objectAtIndex:1] intValue];
    GHAssertEquals(day, 2, @"日の指定が正しくありません");
}

/*
 曜日のリストを取得するためのテスト
 */
- (void)testWeekdaySymbols {
    NSArray *weekdaySymbols = [calendarFunc weekdaySymbols];
    NSInteger count = [weekdaySymbols count];

    GHAssertEqualObjects([weekdaySymbols objectAtIndex:0], @"日", @"週の始まりの指定が正しくありません");
    GHAssertEqualObjects([weekdaySymbols objectAtIndex:6], @"土", @"週の始まりの指定が正しくありません");

    GHAssertEquals(count, 7, @"曜日のリストが正しくありません");
}

/*
 月のリストを取得するためのテスト
 */
- (void)testMonthSymbols {
    NSArray *monthSymbols = [calendarFunc monthSymbols];
    NSInteger count = [monthSymbols count];

    GHAssertEquals(count, 12, @"月のリストが正しくありません");

    GHAssertEqualObjects([monthSymbols objectAtIndex:1], @"2月", @"月の指定が正しくありません");
    GHAssertEqualObjects([monthSymbols objectAtIndex:9], @"10月", @"月の指定が正しくありません");
}

/*
 次月の開始・終了のエポックタイムを取得するためのテスト
 */
- (void)testIncrementMomth {
    [calendarFunc setSelectedDate:[NSDate date]];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDictionary *startEndEpochtime = [calendarFunc incrementMonth];

    NSNumber *startEpochtime = [startEndEpochtime objectForKey:@"startEpochtime"];
    NSDate *startDate = [[NSDate alloc] initWithTimeIntervalSince1970:[startEpochtime doubleValue]];
    NSDateComponents *dc = [calendar components:
            NSYearCalendarUnit |
                    NSMonthCalendarUnit |
                    NSDayCalendarUnit |
                    NSHourCalendarUnit |
                    NSMinuteCalendarUnit |
                    NSSecondCalendarUnit
                                       fromDate:startDate];
    GHAssertEquals([dc year], 2013, @"年の指定が正しくありません");
    GHAssertEquals([dc month], 4, @"月の指定が正しくありません");
    GHAssertEquals([dc day], 1, @"日の指定が正しくありません");

    NSNumber *endEpochtime = [startEndEpochtime objectForKey:@"endEpochtime"];
    NSDate *endDate = [[NSDate alloc] initWithTimeIntervalSince1970:[endEpochtime doubleValue]];
    dc = nil;
    dc = [calendar components:
            NSYearCalendarUnit |
                    NSMonthCalendarUnit |
                    NSDayCalendarUnit |
                    NSHourCalendarUnit |
                    NSMinuteCalendarUnit |
                    NSSecondCalendarUnit
                     fromDate:endDate];
    GHAssertEquals([dc year], 2013, @"年の指定が正しくありません");
    GHAssertEquals([dc month], 4, @"月の指定が正しくありません");
    GHAssertEquals([dc day], 30, @"日の指定が正しくありません");
    GHAssertEquals([dc hour], 23, @"時の指定が正しくありません");
    GHAssertEquals([dc minute], 59, @"分の指定が正しくありません");
    GHAssertEquals([dc second], 59, @"病の指定が正しくありません");

}

/*
 前月の開始・終了のエポックタイムを取得するためのテスト
 */

- (void)testDecrementMonth {
    [calendarFunc setSelectedDate:[NSDate date]];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDictionary *startEndEpochtime = [calendarFunc decrementMonth];

    NSNumber *startEpochtime = [startEndEpochtime objectForKey:@"startEpochtime"];
    NSDate *startDate = [[NSDate alloc] initWithTimeIntervalSince1970:[startEpochtime doubleValue]];
    NSDateComponents *dc = [calendar components:
            NSYearCalendarUnit |
                    NSMonthCalendarUnit |
                    NSDayCalendarUnit |
                    NSHourCalendarUnit |
                    NSMinuteCalendarUnit |
                    NSSecondCalendarUnit
                                       fromDate:startDate];
    GHAssertEquals([dc year], 2013, @"年の指定が正しくありません");
    GHAssertEquals([dc month], 2, @"月の指定が正しくありません");
    GHAssertEquals([dc day], 1, @"日の指定が正しくありません");

    NSNumber *endEpochtime = [startEndEpochtime objectForKey:@"endEpochtime"];
    NSDate *endDate = [[NSDate alloc] initWithTimeIntervalSince1970:[endEpochtime doubleValue]];
    dc = nil;
    dc = [calendar components:
            NSYearCalendarUnit |
                    NSMonthCalendarUnit |
                    NSDayCalendarUnit |
                    NSHourCalendarUnit |
                    NSMinuteCalendarUnit |
                    NSSecondCalendarUnit
                     fromDate:endDate];
    GHAssertEquals([dc year], 2013, @"年の指定が正しくありません");
    GHAssertEquals([dc month], 2, @"月の指定が正しくありません");
    GHAssertEquals([dc day], 28, @"日の指定が正しくありません");
}

/*
 現在の月の開始・終了のエポックタイムを取得するためのテスト
 */
- (void)testCurrentEpochtimes {
    [calendarFunc setSelectedDate:[NSDate date]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDictionary *startEndEpochtime = [calendarFunc currentEpochtimes];

    NSNumber *startEpochtime = [startEndEpochtime objectForKey:@"startEpochtime"];
    NSDate *startDate = [[NSDate alloc] initWithTimeIntervalSince1970:[startEpochtime doubleValue]];
    NSDateComponents *dc = [calendar components:
            NSYearCalendarUnit |
                    NSMonthCalendarUnit |
                    NSDayCalendarUnit |
                    NSHourCalendarUnit |
                    NSMinuteCalendarUnit |
                    NSSecondCalendarUnit
                                       fromDate:startDate];
    GHAssertEquals([dc year], 2013, @"年の指定が正しくありません");
    GHAssertEquals([dc month], 3, @"月の指定が正しくありません");
    GHAssertEquals([dc day], 1, @"日の指定が正しくありません");

    NSNumber *endEpochtime = [startEndEpochtime objectForKey:@"endEpochtime"];
    NSDate *endDate = [[NSDate alloc] initWithTimeIntervalSince1970:[endEpochtime doubleValue]];
    dc = nil;
    dc = [calendar components:
            NSYearCalendarUnit |
                    NSMonthCalendarUnit |
                    NSDayCalendarUnit |
                    NSHourCalendarUnit |
                    NSMinuteCalendarUnit |
                    NSSecondCalendarUnit
                     fromDate:endDate];
    GHAssertEquals([dc year], 2013, @"年の指定が正しくありません");
    GHAssertEquals([dc month], 3, @"月の指定が正しくありません");
    GHAssertEquals([dc day], 31, @"日の指定が正しくありません");
}

- (void)testEpoch2NSDate {
    NSDateComponents *dc = [calendarFunc epoch2DateComponent:@"1358859213"];

    GHAssertEquals([dc year], 2013, @"年の指定が正しくありません");
    GHAssertEquals([dc month], 1, @"月の指定が正しくありません");
    GHAssertEquals([dc day], 22, @"日の指定が正しくありません");
}

- (void)testDaysOfMonthObjects {
    NSArray *objects = [calendarFunc daysOfMonthObjects];
    NSInteger count = [objects count];
    GHAssertEquals(count, 31, @"月の日数が正しくありません");
    GHAssertEquals([[objects objectAtIndex:1] intValue], 2, @"日が正しくありません");
    GHAssertEquals([[objects lastObject] intValue], 31, @"最終日が正しくありません");
}

- (void)testCurrentYear {
    [calendarFunc setSelectedDate:[NSDate date]];
    NSInteger year = [calendarFunc currentYear];
    GHAssertEquals(year, 2013, @"年の指定が正しくありません");
}
@end