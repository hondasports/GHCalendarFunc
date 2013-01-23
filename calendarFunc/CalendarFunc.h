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
@property(strong, nonatomic) NSArray *beforeFirstDayWeekdays;
@property(strong, nonatomic) NSArray *afterEndOfDayWeekdays;
@property(strong, nonatomic) NSArray *weekdaySymbols;
@property(strong, nonatomic) NSArray *monthSymbols;

@property(assign, nonatomic) NSInteger numberOfMonth;
@property(strong, nonatomic) NSArray *numberOfCell;
@property(assign, nonatomic) NSInteger currentMonth;
@property(strong, nonatomic) NSCalendar *calendar;


- (id)init;

- (NSDateFormatter *)currentDateFormatter;

- (NSDictionary *)incrementMonth;

- (NSDictionary *)decrementMonth;

- (NSDictionary *)currentEpochtimes;
@end
