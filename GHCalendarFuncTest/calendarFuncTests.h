//
//  calendarFuncTests.h
//  calendarFuncTests
//
//  Created by MIYAMOTO TATSUYA on 2012/12/18.
//  Copyright (c) 2012年 MIYAMOTO TATSUYA. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <GHUnitIOS/GHUnit.h>
#import "CalendarFunc.h"

@interface calendarFuncTests : GHTestCase {
@private
    CalendarFunc *calendarFunc;
}

- (void)testNumberOfMonth;

- (void)testNumberOfCell;

- (void)testCurrentMonth;

- (void)testBeforeWeekdays;

- (void)testAfterWeekdays;

- (void)testWeekdaySymbols;

- (void)testMonthSymbols;

- (void)testIncrementMomth;

- (void)testDecrementMonth;

- (void)testCurrentEpochtimes;

- (void)testEpoch2NSDate;
@end
