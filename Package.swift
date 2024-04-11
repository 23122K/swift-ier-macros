// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-ier-macros",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "SwiftierMacros",
            targets: ["SwiftierMacros"]
        ),
    ],
    dependencies: [
      .package(
        url: "https://github.com/apple/swift-syntax.git",
        branch: "main"
      ),
    ],
    targets: [
        .target(
            name: "SwiftierMacros",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
            ]
        ),
        .testTarget(
            name: "SwiftierMacrosTests",
            dependencies: ["SwiftierMacros"]
        ),
    ]
)
