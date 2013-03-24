//
//  CalendarFunc.h
//  calendarFunc
//
//  Created by MIYAMOTO TATSUYA on 2012/12/18.
//  Copyright (c) 2012年 MIYAMOTO TATSUYA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarFunc : NSObject {
//    NSDate*         _selectedDate;
    NSCalendar *_calendar;
    NSCalendarUnit _defaultCalendarUnit;
}

@property(strong, nonatomic) NSDate *selectedDate;
@property(readonly, nonatomic) NSArray *beforeFirstDayWeekdays;
@property(readonly, nonatomic) NSArray *afterEndOfDayWeekdays;
@property(readonly, nonatomic) NSArray *weekdaySymbols;
@property(readonly, nonatomic) NSArray *monthSymbols;
@property(readonly, nonatomic) NSArray *numberOfCell;
@property(readonly, nonatomic) NSCalendar *calendar;

@property(readonly, nonatomic) NSDateFormatter *currentDateFormatter;
@property(readonly, nonatomic) NSDictionary *incrementMonth;
@property(readonly, nonatomic) NSDictionary *decrementMonth;
@property(readonly, nonatomic) NSDictionary *currentEpochtimes;
@property(readonly, nonatomic) NSArray *daysOfMonthObjects;

@property(readonly, nonatomic) NSInteger numberOfMonth;
@property(readonly, nonatomic) NSInteger currentMonth;
@property(readonly, nonatomic) NSString *currentYear;

- (id)init;

- (NSDateComponents *)epoch2DateComponent:(NSString *)dateString;

@end
