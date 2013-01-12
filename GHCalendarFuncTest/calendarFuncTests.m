//
//  calendarFuncTests.m
//  calendarFuncTests
//
//  Created by MIYAMOTO TATSUYA on 2012/12/18.
//  Copyright (c) 2012年 MIYAMOTO TATSUYA. All rights reserved.
//

#import "calendarFuncTests.h"

@implementation calendarFuncTests

- (void)setUp
{
    [super setUp];

    // Set-up code here.
    calendarFunc = [[CalendarFunc alloc] init];
    [calendarFunc setSelectedDate:[NSDate date]];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

-(void) testNumberOfMonth{
    NSInteger numberOfMonth = [calendarFunc numberOfMonth];
    GHAssertEquals(numberOfMonth, 31, @"日子の指定が正しくありません");
}

-(void) testNumberOfCell{
//    NSInteger numberOfCell = [calendarFunc numberOfCell];
    NSArray* allDays = [calendarFunc numberOfCell];
    NSInteger count = [allDays count];
    
    GHAssertEquals(count, 35, @"セルの数が正しくありません");
}

-(void) testCurrentMonth{
    NSInteger currentMonth = [calendarFunc currentMonth];
    GHAssertEquals(currentMonth, 1, @"指定された月が正しくありません");
}

/*
 1日以前の日数と、その日を取得するためのテスト
 */
-(void) testBeforeWeekdays{
    NSArray* weekDays = [calendarFunc beforeFirstDayWeekdays];
    NSInteger count = [weekDays count];
    GHAssertEquals(count, 2, @"1日以前の日数の指定が正しくありません");
    
    int day = [[weekDays objectAtIndex:0] intValue];
    GHAssertEquals(day, 30, @"日の指定が正しくありません");
    
    day = [[weekDays objectAtIndex:1] intValue];
    GHAssertEquals(day, 31, @"日の指定が正しくありません");
}

/*
 月の最終日以降の日数と、その日を取得する為のテスト
 */
-(void) testAfterWeekdays{
    NSArray* weekDays = [calendarFunc afterEndOfDayWeekdays];
    NSInteger count = [weekDays count];
    GHAssertEquals(count, 2, @"最終日以降の日数の指定が正しくありません");

    int day = [[weekDays objectAtIndex:0] intValue];
    GHAssertEquals(day, 1, @"日の指定が正しくありません");
    
    day = [[weekDays objectAtIndex:1] intValue];
    GHAssertEquals(day, 2, @"日の指定が正しくありません");
}

-(void) testWeekdaySymbols{
    NSArray* weekdaySymbols = [calendarFunc weekdaySymbols];
    NSInteger count = [weekdaySymbols count];

    GHAssertEqualObjects([weekdaySymbols objectAtIndex:0], @"日", @"週の始まりの指定が正しくありません");
    GHAssertEqualObjects([weekdaySymbols objectAtIndex:6], @"土", @"週の始まりの指定が正しくありません");
    
    GHAssertEquals(count, 7, @"曜日のリストが正しくありません");
}

-(void)testMonthSymbols{
    NSArray* monthSymbols = [calendarFunc monthSymbols];
    NSInteger count = [monthSymbols count];

    GHAssertEquals(count, 12, @"月のリストが正しくありません");
    
    GHAssertEqualObjects([monthSymbols objectAtIndex:1], @"2月", @"月の指定が正しくありません");
    GHAssertEqualObjects([monthSymbols objectAtIndex:9], @"10月", @"月の指定が正しくありません");
}

-(void)testStartEndEpochtime{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDictionary* startEndEpochtime = [calendarFunc startEndEpochtime];
    
    NSNumber* startEpochtime = [startEndEpochtime objectForKey:@"startEpochtime"];
    NSDate* startDate = [[NSDate alloc] initWithTimeIntervalSince1970:[startEpochtime doubleValue]];
    NSDateComponents* dc = [calendar components:
                                   NSYearCalendarUnit   |
                                   NSMonthCalendarUnit  |
                                   NSDayCalendarUnit    |
                                   NSHourCalendarUnit   |
                                   NSMinuteCalendarUnit |
                                   NSSecondCalendarUnit
                                       fromDate:startDate];

    GHAssertEquals([dc year], 2012, @"年の指定が正しくありません");
    GHAssertEquals([dc month], 12, @"月の指定が正しくありません");
    GHAssertEquals([dc day], 1, @"日の指定が正しくありません");

}

@end