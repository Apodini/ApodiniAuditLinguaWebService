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
        .package(name: "Apodini", path: "../Apodini")
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
                .target(name: "Shared")
            ]),
        .target(
            name: "Shared",
            dependencies: [
                .product(name: "Apodini", package: "Apodini")
            ]),
        .testTarget(
            name: "LinguaWebServiceTests",
            dependencies: [
                .target(name: "BadLinguaWebService"),
                .target(name: "ImprovedLinguaWebService")
            ]
        )
    ]
)
