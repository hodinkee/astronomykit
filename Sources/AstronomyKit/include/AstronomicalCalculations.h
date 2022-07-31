//
//  AstronomicalCalculations.h
//  AstronomyKit
//
//  Created by Caleb Davenport on 12/8/14.
//  Copyright © 2015-2016 HODINKEE. All rights reserved.
//

#if defined(__has_feature) && __has_feature(objc_modules)
    @import Foundation;
    @import CoreLocation;
#else
    #import <Foundation/Foundation.h>
    #import <CoreLocation/CoreLocation.h>
#endif

@interface AstronomicalCalculations : NSObject

#pragma mark - Lunar calculations

/// Ask when the moon will rise in the given date and location.
///
/// @param date The date to query.
///
/// @param location The location to query.
+ (nullable NSDate *)lunarRiseDateWithDate:(nonnull NSDate *)date location:(CLLocationCoordinate2D)location;

/// Ask when the moon will reach its meridien in the given date and location.
///
/// @param date The date to query.
///
/// @param location The location to query.
+ (nonnull NSDate *)lunarTransitDateWithDate:(nonnull NSDate *)date location:(CLLocationCoordinate2D)location;

/// Ask when the moon will set in the given date and location.
///
/// @param date The date to query.
///
/// @param location The location to query.
+ (nullable NSDate *)lunarSetDateWithDate:(nonnull NSDate *)date location:(CLLocationCoordinate2D)location;

/// Ask when the given true lunar phase will happen for the lunation that
/// conatins the given date.
///
/// @param phase The true lunar phase as 0.0, 0.25, 0.5, or 0.75 for new, first quarter, full, and third quarter respectively.
///
/// @param date The date for the lunation to query.
+ (nonnull NSDate *)dateForTrueLunarPhase:(double)phase withDate:(nonnull NSDate *)date;

+ (double)lunarPhaseAngleWithDate:(nonnull NSDate *)date;

+ (double)lunarPositionAngleWithDate:(nonnull NSDate *)date;

/// Ask for the moon phase with the given date as a value in the range 0...1.
///
/// @param date The date to query.
///
/// @return The moon phase for the given date as a value in the range 0...1.
+ (double)lunarPhaseWithDate:(nonnull NSDate *)date;

#pragma mark - Solar calculations


/// Ask when the sun will rise in the given date and location.
///
/// @param date The date to query.
///
/// @param location The location to query.
+ (nullable NSDate *)solarRiseDateWithDate:(nonnull NSDate *)date location:(CLLocationCoordinate2D)location;

/// Ask when the sun will reach its meridien in the given date and location.
///
/// @param date The date to query.
///
/// @param location The location to query.
+ (nonnull NSDate *)solarTransitDateWithDate:(nonnull NSDate *)date location:(CLLocationCoordinate2D)location;

/// Ask when the sun will set in the given date and location.
///
/// @param date The date to query.
///
/// @param location The location to query.
+ (nullable NSDate *)solarSetDateWithDate:(nonnull NSDate *)date location:(CLLocationCoordinate2D)location;

@end
