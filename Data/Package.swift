// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Data",
            targets: ["Data"]),
    ],
    dependencies: [
        .package(url: "https://github.com/joshuawright11/papyrus", .upToNextMajor(from: "0.6.7")),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", branch: "master"),
        .package(url: "https://github.com/groue/Semaphore.git", .upToNextMajor(from: "0.0.8")),
        .package(path: "../Domain"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Data",
            dependencies: [
                .product(name: "Papyrus", package: "papyrus"),
                .product(name: "KeychainAccess", package: "KeychainAccess"),
                .product(name: "Domain", package: "Domain"),
                .product(name: "Semaphore", package: "Semaphore"),
            ]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"]),
    ]
)
