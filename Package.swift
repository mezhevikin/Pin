// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "Pin",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "Pin",
            targets: ["Pin"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Pin",
            dependencies: []),
        .testTarget(
            name: "PinTests",
            dependencies: ["Pin"]),
    ]
)
