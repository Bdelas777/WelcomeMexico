// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Mexico",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "Mexico",
            targets: ["AppModule"],
            bundleIdentifier: "bernardo.Mexico",
            teamIdentifier: "X5KY75J3RV",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .dog),
            accentColor: .presetColor(.indigo),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            appCategory: .education
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .process("Resources")
            ]
        )
    ]
)