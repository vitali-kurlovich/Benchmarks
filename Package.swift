// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-benchmarks",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .watchOS(.v6),
        .tvOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Benchmarks",
            targets: ["Benchmarks"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/heroesofcode/CLI-Table-Swift", from: "1.1.0"),
        .package(url: "https://github.com/vapor/console-kit/", from: "4.15.2"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.7.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Benchmarks",
            dependencies: [
                .product(name: "ConsoleKit", package: "console-kit"),
                .product(name: "CLITable", package: "CLI-Table-Swift"),
            ]
        ),
    ]
)
