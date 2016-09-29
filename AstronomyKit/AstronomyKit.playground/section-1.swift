import Foundation
import CoreLocation
import AstronomyKit

let date = Date()

extension CLLocationCoordinate2D {
    static var SanFrancisco: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 37.7833, longitude: -122.4167)
    }
}

AstronomicalCalculations.lunarRiseDate(with: date, location: .SanFrancisco)
AstronomicalCalculations.lunarTransitDate(with: date, location: .SanFrancisco)
AstronomicalCalculations.lunarSetDate(with: date, location: .SanFrancisco)

AstronomicalCalculations.solarRiseDate(with: date, location: .SanFrancisco)
AstronomicalCalculations.solarTransitDate(with: date, location: .SanFrancisco)
AstronomicalCalculations.solarSetDate(with: date, location: .SanFrancisco)

AstronomicalCalculations.date(forTrueLunarPhase: 0.0, with: date) // New
AstronomicalCalculations.date(forTrueLunarPhase: 0.25, with: date) // First quarter
AstronomicalCalculations.date(forTrueLunarPhase: 0.5, with: date) // Full
AstronomicalCalculations.date(forTrueLunarPhase: 0.75, with: date) // Last quarter

AstronomicalCalculations.lunarPhaseAngle(with: date)
AstronomicalCalculations.lunarPositionAngle(with: date)
AstronomicalCalculations.lunarPhase(with: date)
