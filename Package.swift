// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "psc",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
        .package(url: "https://github.com/leviouwendijk/plate.git", from: "1.0.2"),
        .package(url: "https://github.com/leviouwendijk/Economics.git", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "psc",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "plate", package: "plate"),
                .product(name: "Economics", package: "Economics"),
            ]
        ),
    ]
)
