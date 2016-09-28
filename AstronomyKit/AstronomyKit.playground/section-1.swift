import Foundation
import CoreLocation
import AstronomyKit

let date = NSDate()

let SanFrancisco = CLLocationCoordinate2D(latitude: 37.7833, longitude: -122.4167)

AstronomicalCalculations.lunarRiseDateWithDate(date, location: SanFrancisco)
AstronomicalCalculations.lunarTransitDateWithDate(date, location: SanFrancisco)
AstronomicalCalculations.lunarSetDateWithDate(date, location: SanFrancisco)

AstronomicalCalculations.solarRiseDateWithDate(date, location: SanFrancisco)
AstronomicalCalculations.solarTransitDateWithDate(date, location: SanFrancisco)
AstronomicalCalculations.solarSetDateWithDate(date, location: SanFrancisco)

AstronomicalCalculations.dateForTrueLunarPhase(0.0, withDate: date) // New
AstronomicalCalculations.dateForTrueLunarPhase(0.25, withDate: date) // First quarter
AstronomicalCalculations.dateForTrueLunarPhase(0.5, withDate: date) // Full
AstronomicalCalculations.dateForTrueLunarPhase(0.75, withDate: date) // Last quarter

AstronomicalCalculations.lunarPhaseAngleWithDate(date)
AstronomicalCalculations.lunarPositionAngleWithDate(date)
AstronomicalCalculations.lunarPhaseWithDate(date)
