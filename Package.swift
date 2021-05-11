// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ZXDB-SDK",
    platforms: [
        .iOS(.v12),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "ZXDB-SDK",
            targets: ["ZXDB-SDK"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ZXDB-SDK",
            dependencies: [],
            path: "ZXDB-SDK"),
        .testTarget(
            name: "ZXDB-SDKTests",
            dependencies: ["ZXDB-SDK"],
            path: "ZXDB-SDKTests"),
    ],
    swiftLanguageVersions: [.v5]
)
