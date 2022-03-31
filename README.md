# `AstronomyKit`

`AstronomyKit` works with [AA+](http://www.naughter.com/aa.html) to provide an Objective-C API for performing complex calculations about the Solar System.

## Usage

Add `AstronomyKit` to any Xcode project via the [package dependencies](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app) tab. Alternately, add `AstronomyKit` to the dependencies of another Swift package:

```
.package(url: "https://github.com/hodinkee/AstronomyKit", .branch("spm"))
```

Functionality includes the following calculations:

```
import CoreLocation
import AstronomyKit

let date: Date = Date()
let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)

AstronomicalCalculations.lunarRiseDate(with: date, location: location)
AstronomicalCalculations.lunarTransitDate(with: date, location: location)
AstronomicalCalculations.lunarSetDate(with: date, location: location)

AstronomicalCalculations.solarRiseDate(with: date, location: location)
AstronomicalCalculations.solarTransitDate(with: date, location: location)
AstronomicalCalculations.solarSetDate(with: date, location: location)

AstronomicalCalculations.date(forTrueLunarPhase: 0.0, with: date) // New
AstronomicalCalculations.date(forTrueLunarPhase: 0.25, with: date) // First quarter
AstronomicalCalculations.date(forTrueLunarPhase: 0.5, with: date) // Full
AstronomicalCalculations.date(forTrueLunarPhase: 0.75, with: date) // Last quarter

AstronomicalCalculations.lunarPhaseAngle(with: date)
AstronomicalCalculations.lunarPositionAngle(with: date)
AstronomicalCalculations.lunarPhase(with: date)
```

## Requirements

Requires [Xcode](https://developer.apple.com/xcode) 13.3 or newer to build.

### AA+ Included

`AstronomyKit` bundles [Naughter Software AA+](http://naughter.com/aa.html) v2.42.

### Platform Targets

* [macOS](https://developer.apple.com/macos) 11 Big Sur
* [iOS](https://developer.apple.com/ios)/[iPadOS](https://developer.apple.com/ipados)/[tvOS](https://developer.apple.com/tvos) 14
* [watchOS](https://developer.apple.com/watchos) 7
