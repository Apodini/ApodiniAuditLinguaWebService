//
// This source file is part of the Apodini open source project
//
// SPDX-FileCopyrightText: 2019-2021 Paul Schmiedmayer and the Apodini project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini
import ApodiniHTTP
import ApodiniREST
import ApodiniAudit
import ArgumentParser
import Shared
import ApodiniAuthorizationBasicScheme
import ApodiniAuthorization
import ApodiniAudit
import ApodiniDatabase
import FluentSQLiteDriver

@main
struct ImprovedLinguaWebService: Apodini.WebService {
    var content: some Component {
        Group("en") {
            Group("lectures") {
                LectureComponent(language: .english)
            }
            Group("dictionary") {
                DictionaryComponent(language: .english)
            }
        }
        Group("de") {
            Group("lektionen") {
                LectureComponent(language: .german)
            }
            Group("woerterbuch") {
                DictionaryComponent(language: .german)
            }
        }
        .metadata {
            SelectBestPractices(.exclude, .linguistic)
        }
    }
    
    var configuration: Configuration {
        REST {
            APIAuditor {
                RestrictDictionaryEntryResource(allowedPrefixes: [
                    "/en/dictionary",
                    "/de/woerterbuch"
                ])
                ParameterCountConfiguration(maximumCount: 15)
                URLPathSegmentLengthConfiguration(allowedSegments: ["en", "de"])
            }
        }
        
        DatabaseConfiguration(.sqlite(.memory), as: .sqlite)
            .addMigrations(DictionaryMigration())
    }
    
    var metadata: AnyWebServiceMetadata {
        Authorize(
            MockCredentials<Int>.self,
            using: BasicAuthenticationScheme(),
            verifiedBy: MockCredentialVerifier(expectedPassword: "123456", state: 1))
    }
}

enum Language {
    case german, english
}
