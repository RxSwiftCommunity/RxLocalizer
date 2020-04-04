// swift-tools-version:5.1
//
//  Package.swift
//  RxLocalizer
//
//  Created by Vladislav on 21.12.2019.
//  Copyright (c) RxSwiftCommunity
//

import PackageDescription

let package = Package(
    name: "RxLocalizer",
    
    platforms: [
        .iOS(.v10),
        .tvOS(.v10),
        .macOS(.v10_12),
        .watchOS(.v3)
    ],
    products: [
        .library(name: "RxLocalizer", targets: ["RxLocalizer"])
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.1.1"))
    ],
    targets: [
         .target(
            name: "RxLocalizer",
            dependencies: ["RxSwift", "RxCocoa"],
            path: "Source")
    ]
)
