// swift-tools-version: 5.6

import PackageDescription

let package = Package(name: "AstronomyKit", platforms: [
        .macOS(.v11),
        .iOS(.v14),
        .watchOS(.v7),
        .tvOS(.v14)
    ], products: [
        .library(name: "AstronomyKit", targets: [
            "AstronomyKit"
        ]), /*
        .library(name: "AAPlus", targets: [
            "AAPlus"
        ]) */
    ], targets: [
        .target(name: "AstronomyKit", dependencies: [
            "AAPlus"
        ]),
        .target(name: "AAPlus",  exclude: [
            "CMakeLists.txt",
            "index.html"
        ])
    ], cxxLanguageStandard: .cxx20)
