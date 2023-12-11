// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "skip-ui",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "SkipUI", targets: ["SkipUI"]),
    ],
    dependencies: [ 
        .package(url: "https://source.skip.tools/skip.git", from: "0.7.32"),
        .package(url: "https://source.skip.tools/skip-model.git", from: "0.3.2"),
    ],
    targets: [
        .target(name: "SkipUI", dependencies: [
            .product(name: "SkipModel", package: "skip-model")
            ],
            plugins: [.plugin(name: "skipstone", package: "skip")]),
        .testTarget(name: "SkipUITests", dependencies: ["SkipUI", .product(name: "SkipTest", package: "skip")],
            plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
