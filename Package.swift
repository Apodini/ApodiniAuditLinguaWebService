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
        .executable(name: "LinguaWebService", targets: ["LinguaWebService"])
    ],
    dependencies: [
        .package(name: "Apodini", path: "../Apodini")
    ],
    targets: [
        .executableTarget(
            name: "LinguaWebService",
            dependencies: [
                .product(name: "Apodini", package: "Apodini"),
                .product(name: "ApodiniHTTP", package: "Apodini"),
                .product(name: "ApodiniREST", package: "Apodini"),
                .product(name: "ApodiniAudit", package: "Apodini")
            ]),
        .testTarget(
            name: "LinguaWebServiceTests",
            dependencies: [
                .target(name: "LinguaWebService")
            ]
        )
    ]
)
