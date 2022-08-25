// swift-tools-version:5.6

//
// This source file is part of the Apodini open source project
// 
// SPDX-FileCopyrightText: 2021 Paul Schmiedmayer and the project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import PackageDescription


let package = Package(
    name: "ApodiniAuditLinguaWebService",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .executable(name: "BadLinguaWebService", targets: ["BadLinguaWebService"]),
        .executable(name: "ImprovedLinguaWebService", targets: ["ImprovedLinguaWebService"])
    ],
    dependencies: [
        // FUTURE change to standard Apodini
        .package(url: "https://github.com/Apodini/Apodini.git", branch: "develop"),
        .package(url: "https://github.com/vapor/fluent-kit.git", from: "1.16.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver", from: "4.2.0")
    ],
    targets: [
        .executableTarget(
            name: "BadLinguaWebService",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .product(name: "ApodiniHTTP", package: "Apodini"),
                .product(name: "ApodiniREST", package: "Apodini"),
                .product(name: "ApodiniAudit", package: "Apodini"),
                .product(name: "ApodiniOpenAPI", package: "Apodini"),
                .product(name: "ApodiniDatabase", package: "Apodini"),
                .product(name: "ApodiniAuthorizationBasicScheme", package: "Apodini"),
                .product(name: "ApodiniAuthorization", package: "Apodini"),
                .product(name: "FluentKit", package: "fluent-kit"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
                .target(name: "Shared")
            ]),
        .executableTarget(
            name: "ImprovedLinguaWebService",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .product(name: "ApodiniHTTP", package: "Apodini"),
                .product(name: "ApodiniREST", package: "Apodini"),
                .product(name: "ApodiniAudit", package: "Apodini"),
                .product(name: "ApodiniOpenAPI", package: "Apodini"),
                .product(name: "ApodiniDatabase", package: "Apodini"),
                .product(name: "ApodiniAuthorizationBasicScheme", package: "Apodini"),
                .product(name: "ApodiniAuthorization", package: "Apodini"),
                .product(name: "FluentKit", package: "fluent-kit"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
                .target(name: "Shared")
            ]),
        .target(
            name: "Shared",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .product(name: "ApodiniDatabase", package: "Apodini"),
                .product(name: "ApodiniAudit", package: "Apodini")
            ],
            resources: [
                .process("Resources")
            ]),
        .testTarget(
            name: "LinguaWebServiceTests",
            dependencies: [
                .target(name: "BadLinguaWebService"),
                .target(name: "ImprovedLinguaWebService"),
                .product(name: "XCTApodiniNetworking", package: "Apodini"),
                .product(name: "ApodiniHTTPProtocol", package: "Apodini"),
                .product(name: "XCTApodini", package: "Apodini")
            ]
        )
    ]
)
