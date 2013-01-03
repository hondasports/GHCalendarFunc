//
//  CalendarFunc.h
//  calendarFunc
//
//  Created by MIYAMOTO TATSUYA on 2012/12/18.
//  Copyright (c) 2012年 MIYAMOTO TATSUYA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GHUnitIOS/GHUnit.h>

@interface CalendarFunc : GHTestCase{
    NSDate*         _selectedDate;
    NSCalendar*     _calendar;
    NSCalendarUnit  _defaultCalendarUnit;
    NSArray*        _beforeFirstDayWeekdays;
    NSArray*        _afterEndOfDayWeekdays;
    NSInteger       _numberOfMonth;
    NSArray*        _numberOfCell;
    NSInteger       _currentMonth;
    NSArray*        _weekdaySymbols;
    NSArray*        _monthSymbols;
}

@property (strong, nonatomic) NSDate*   selectedDate;
@property (strong, nonatomic) NSArray*  beforeFirstDayWeekdays;
@property (strong, nonatomic) NSArray*  afterEndOfDayWeekdays;
@property (strong, nonatomic) NSArray*  weekdaySymbols;
@property (strong, nonatomic) NSArray*  monthSymbols;

@property (assign, nonatomic) NSInteger numberOfMonth;
@property (strong, nonatomic) NSArray*  numberOfCell;
@property (assign, nonatomic) NSInteger currentMonth;

-(id) init;
-(NSDateFormatter *) currentDateFormatter;
@end
