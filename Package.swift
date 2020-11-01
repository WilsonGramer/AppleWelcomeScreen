// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "AppleWelcomeScreen",
    platforms: [.iOS("11.0")],
    products: [
    	.library(name: "AppleWelcomeScreen", targets: ["AppleWelcomeScreen"]),
    ],
    targets: [
    	.target(name: "AppleWelcomeScreen", path: "./Sources"),
    ]
)
