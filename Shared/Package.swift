// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Shared",
            targets: ["Shared"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject", .upToNextMajor(from: "2.8.4")),
        .package(url: "https://github.com/Swinject/SwinjectAutoregistration", .upToNextMajor(from: "2.8.3")),
        .package(url: "https://github.com/lutes1/PublicInitialiserMacro", branch: "main"),
        .package(url: "https://github.com/Instabug/Instabug-SP", branch: "support_modern_swift_concurrency_apis_spm"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Shared",
            dependencies: [
                .product(name: "Swinject", package: "Swinject"),
                .product(name: "SwinjectAutoregistration", package: "SwinjectAutoregistration"),
                .product(name: "PublicInitialiserMacro", package: "PublicInitialiserMacro"),
                .product(name: "Instabug", package: "Instabug-SP"),
            ]
        ),
        .testTarget(
            name: "SharedTests",
            dependencies: ["Shared"]),
    ]
)
