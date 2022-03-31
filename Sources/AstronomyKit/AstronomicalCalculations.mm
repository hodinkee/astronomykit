//
//  AstronomicalCalculations.m
//  AstronomyKit
//
//  Created by Caleb Davenport on 12/8/14.
//  Copyright © 2015-2016 HODINKEE. All rights reserved.
//

#import "AstronomicalCalculations.h"
#import "NSCalendar+AstronomyKit.h"
#import "AA.h"

@implementation AstronomicalCalculations

#pragma mark - Lunar calculations

+ (NSDate *)lunarRiseDateWithDate:(NSDate *)date location:(CLLocationCoordinate2D)location {
    double julianDate = [self julianDateWithDate:date];
    CAARiseTransitSetDetails transitSet = [self lunarRiseTransitSetWithJulianDate:julianDate latitude:location.latitude longitude:-location.longitude];
    if (transitSet.bRiseValid) {
        double transitDate = julianDate + transitSet.Rise / 24.0;
        return [self dateWithJulianDateTime:transitDate];
    }
    return NULL;
}

+ (NSDate *)lunarTransitDateWithDate:(NSDate *)date location:(CLLocationCoordinate2D)location {
    double julianDate = [self julianDateWithDate:date];
    CAARiseTransitSetDetails transitSet = [self lunarRiseTransitSetWithJulianDate:julianDate latitude:location.latitude longitude:-location.longitude];
    double transitDate = julianDate + transitSet.Transit / 24.0;
    return [self dateWithJulianDateTime:transitDate];
}

+ (NSDate *)lunarSetDateWithDate:(NSDate *)date location:(CLLocationCoordinate2D)location {
    double julianDate = [self julianDateWithDate:date];
    CAARiseTransitSetDetails transitSet = [self lunarRiseTransitSetWithJulianDate:julianDate latitude:location.latitude longitude:-location.longitude];
    if (transitSet.bSetValid) {
        double transitDate = julianDate + transitSet.Set / 24.0;
        return [self dateWithJulianDateTime:transitDate];
    }
    return NULL;
}

+ (NSDate *)dateForTrueLunarPhase:(double)phase withDate:(NSDate *)date {

    //
    // Calculate the Julain date for the given date. This will be used to
    // determine the appropriate lunation for all calculations.
    //
    double julianDate = [self julianDateTimeWithDate:date];

    //
    // Calculate initial new moon based on the given date. This is an
    // approximation that will be refined later.
    //
    double fractionalYear = [self fracionalYearWithDate:date];
    double k = round(CAAMoonPhases::K(fractionalYear));
    double dynamicalTime = CAAMoonPhases::TruePhase(k);
    double phaseDate = CAADynamicalTime::TT2UTC(dynamicalTime);

    //
    // Enumerate over whole values of k until we find a suitable lunation.
    //
    while (phaseDate > julianDate) {
        k--;
        dynamicalTime = CAAMoonPhases::TruePhase(k);
        phaseDate = CAADynamicalTime::TT2UTC(dynamicalTime);
    }

    //
    // Calculate the final value for the desired phase.
    //
    k += phase;
    dynamicalTime = CAAMoonPhases::TruePhase(k);
    phaseDate = CAADynamicalTime::TT2UTC(dynamicalTime);

    return [self dateWithJulianDateTime:phaseDate];
}

+ (double)lunarPhaseAngleWithDate:(NSDate *)date {
    double julianDate = [self julianDateTimeWithDate:date];
    CAA2DCoordinate lunarCoordinate = [self lunarCoordinatesWithJulianDate:julianDate];
    CAA2DCoordinate solarCoordinate = [self solarCoordinatesWithJulianDate:julianDate];
    double elongation = CAAMoonIlluminatedFraction::GeocentricElongation(lunarCoordinate.X, lunarCoordinate.Y, solarCoordinate.X, solarCoordinate.Y);
    return CAAMoonIlluminatedFraction::PhaseAngle(elongation, 368410.0, 149971520.0);
}

+ (double)lunarPositionAngleWithDate:(NSDate *)date {
    double julianDate = [self julianDateTimeWithDate:date];
    CAA2DCoordinate lunarCoordinate = [self lunarCoordinatesWithJulianDate:julianDate];
    CAA2DCoordinate solarCoordinate = [self solarCoordinatesWithJulianDate:julianDate];
    return CAAMoonIlluminatedFraction::PositionAngle(solarCoordinate.X, solarCoordinate.Y, lunarCoordinate.X, lunarCoordinate.Y);
}

+ (double)lunarPhaseWithDate:(nonnull NSDate *)date {
    double phase = [AstronomicalCalculations lunarPhaseAngleWithDate:date];
    double position = [AstronomicalCalculations lunarPositionAngleWithDate:date];
    return (position < 180.0 ? phase + 180.0 : 180.0 - phase) / 360.0;
}

#pragma mark - Solar calculations

+ (NSDate *)solarRiseDateWithDate:(NSDate *)date location:(CLLocationCoordinate2D)location {
    double julianDate = [self julianDateWithDate:date];
    CAARiseTransitSetDetails transitSet = [self solarRiseTransitSetWithJulianDate:julianDate latitude:location.latitude longitude:-location.longitude];
    if (transitSet.bRiseValid) {
        double transitDate = julianDate + transitSet.Rise / 24.0;
        return [self dateWithJulianDateTime:transitDate];
    }
    return NULL;
}

+ (NSDate *)solarTransitDateWithDate:(NSDate *)date location:(CLLocationCoordinate2D)location {
    double julianDate = [self julianDateWithDate:date];
    CAARiseTransitSetDetails transitSet = [self solarRiseTransitSetWithJulianDate:julianDate latitude:location.latitude longitude:-location.longitude];
    double transitDate = julianDate + transitSet.Transit / 24.0;
    return [self dateWithJulianDateTime:transitDate];
}

+ (NSDate *)solarSetDateWithDate:(NSDate *)date location:(CLLocationCoordinate2D)location {
    double julianDate = [self julianDateWithDate:date];
    CAARiseTransitSetDetails transitSet = [self solarRiseTransitSetWithJulianDate:julianDate latitude:location.latitude longitude:-location.longitude];
    if (transitSet.bSetValid) {
        double transitDate = julianDate + transitSet.Set / 24.0;
        return [self dateWithJulianDateTime:transitDate];
    }
    return NULL;
}

#pragma mark - Private

+ (double)julianDateWithDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar AstronomyKitGregorianCalendar];
    NSCalendarUnit units = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay);
    NSDateComponents *components = [calendar components:units fromDate:date];
    CAADate otherDate = CAADate(components.year, components.month, components.day, true);
    return otherDate.Julian();
}

+ (double)julianDateTimeWithDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar AstronomyKitGregorianCalendar];
    NSCalendarUnit units = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);
    NSDateComponents *components = [calendar components:units fromDate:date];
    CAADate otherDate = CAADate(components.year, components.month, components.day, components.hour, components.minute, components.second, true);
    return otherDate.Julian();
}

+ (NSDate *)dateWithJulianDateTime:(double)julianDate {
    CAADate otherDate = CAADate(julianDate, true);
    long year = 0;
    long month = 0;
    long day = 0;
    long hour = 0;
    long minute = 0;
    double second = 0;
    otherDate.Get(year, month, day, hour, minute, second);
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    components.year = year;
    components.month = month;
    components.day = day;
    components.hour = hour;
    components.minute = minute;
    components.second = (NSInteger)second;
    
    NSCalendar *calendar = [NSCalendar AstronomyKitGregorianCalendar];
    return [calendar dateFromComponents:components];
}

+ (double)fracionalYearWithDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar AstronomyKitGregorianCalendar];
    NSCalendarUnit units = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);
    NSDateComponents *components = [calendar components:units fromDate:date];
    CAADate otherDate = CAADate(components.year, components.month, components.day, components.hour, components.minute, components.second, true);
    return otherDate.FractionalYear();
}

+ (CAA2DCoordinate)lunarCoordinatesWithJulianDate:(double)julianDate {
    double terestrialTime = CAADynamicalTime::UTC2TT(julianDate);
    double lambda = CAAMoon::EclipticLongitude(terestrialTime);
    double beta = CAAMoon::EclipticLatitude(terestrialTime);
    double epsilon = CAANutation::TrueObliquityOfEcliptic(terestrialTime);
    return CAACoordinateTransformation::Ecliptic2Equatorial(lambda, beta, epsilon);
}

+ (CAARiseTransitSetDetails)lunarRiseTransitSetWithJulianDate:(double)julianDate latitude:(double)latitude longitude:(double)longitude {
    CAA2DCoordinate firstCoordinate = [self lunarCoordinatesWithJulianDate:julianDate - 1.0];
    CAA2DCoordinate secondCoordinate = [self lunarCoordinatesWithJulianDate:julianDate];
    CAA2DCoordinate thirdCoordinate = [self lunarCoordinatesWithJulianDate:julianDate + 1.0];
    return CAARiseTransitSet::Calculate(CAADynamicalTime::UTC2TT(julianDate), firstCoordinate.X, firstCoordinate.Y, secondCoordinate.X, secondCoordinate.Y, thirdCoordinate.X, thirdCoordinate.Y, longitude, latitude, 0.125);
}

+ (CAA2DCoordinate)solarCoordinatesWithJulianDate:(double)julianDate {
    double terestrialTime = CAADynamicalTime::UTC2TT(julianDate);
    double lambda = CAASun::ApparentEclipticLongitude(terestrialTime, true);
    double beta = CAASun::ApparentEclipticLatitude(terestrialTime, true);
    double epsilon = CAANutation::TrueObliquityOfEcliptic(terestrialTime);
    return CAACoordinateTransformation::Ecliptic2Equatorial(lambda, beta, epsilon);
}

+ (CAARiseTransitSetDetails)solarRiseTransitSetWithJulianDate:(double)julianDate latitude:(double)latitude longitude:(double)longitude {
    CAA2DCoordinate firstCoordinate = [self solarCoordinatesWithJulianDate:julianDate - 1.0];
    CAA2DCoordinate secondCoordinate = [self solarCoordinatesWithJulianDate:julianDate];
    CAA2DCoordinate thirdCoordinate = [self solarCoordinatesWithJulianDate:julianDate + 1.0];
    return CAARiseTransitSet::Calculate(CAADynamicalTime::UTC2TT(julianDate), firstCoordinate.X, firstCoordinate.Y, secondCoordinate.X, secondCoordinate.Y, thirdCoordinate.X, thirdCoordinate.Y, longitude, latitude, -0.8333);
}

@end
