//
//  NSCalendar+AstronomyKit.m
//  Watchville
//
//  Created by Caleb Davenport on 2/9/15.
//  Copyright (c) 2015 North Technologies, Inc. All rights reserved.
//

#import "NSCalendar+AstronomyKit.h"

static NSString *const NSCalendar_AstronomyKit_SharedGregorianCalendarKey = @"com.north.AstronomyKit.SharedGregorianCalendar";

@implementation NSCalendar (AstronomyKit)

+ (instancetype)AstronomyKit_GregorianCalendar {
    NSThread *thread = [NSThread currentThread];
    NSMutableDictionary *dictionary = [thread threadDictionary];
    NSCalendar *calendar = dictionary[NSCalendar_AstronomyKit_SharedGregorianCalendarKey];
    if (calendar == nil) {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        dictionary[NSCalendar_AstronomyKit_SharedGregorianCalendarKey] = calendar;
    }
    return calendar;
}

@end
