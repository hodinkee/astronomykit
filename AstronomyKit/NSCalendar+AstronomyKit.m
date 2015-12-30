//
//  NSCalendar+AstronomyKit.m
//  Watchville
//
//  Created by Caleb Davenport on 2/9/15.
//  Copyright (c) 2015 North Technologies, Inc. All rights reserved.
//

#import "NSCalendar+AstronomyKit.h"

static NSString *const AstronomyKitSharedGregorianCalendarKey = @"com.hodinkee.AstronomyKit.SharedGregorianCalendar";

@implementation NSCalendar (AstronomyKit)

+ (instancetype)AstronomyKitGregorianCalendar {
    NSThread *thread = [NSThread currentThread];
    NSMutableDictionary *dictionary = [thread threadDictionary];
    NSCalendar *calendar = dictionary[AstronomyKitSharedGregorianCalendarKey];
    if (calendar == nil) {
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        dictionary[AstronomyKitSharedGregorianCalendarKey] = calendar;
    }
    return calendar;
}

@end
