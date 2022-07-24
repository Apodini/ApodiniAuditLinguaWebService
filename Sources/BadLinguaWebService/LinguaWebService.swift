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
import ApodiniAuthorization
import ApodiniAuthorizationBasicScheme
import Shared

@main
struct BadLinguaWebService: Apodini.WebService {
    var content: some Component {
        Group("en") {
            Group("lectures") {
                LectureComponent(language: .english)
            }
            Group("dictionary") {
                DictionaryComponent(language: .english)
            }
            Group("getFavoriteLectures") {
                GetFavoriteLecturesHandler()
            }
            Group("favorites") {
                DictionaryFavoritesComponent()
            }
        }
        Group("de") {
            Group("lektionen") {
                LectureComponent(language: .german)
            }
            Group("woerterbuch") {
                DictionaryComponent(language: .german)
            }
            Group("holeFavorisierteLektionen") {
                GetFavoriteLecturesHandler()
            }
            Group("favoriten") {
                DictionaryFavoritesComponent()
            }
        }
    }
    
    var configuration: Configuration {
        REST {
            APIAuditor {
                RestrictDictionaryEntryResource(allowedPrefixes: [
                    "/en/dictionary",
                    "/de/woerterbuch"
                ])
            }
        }
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
