//
// This source file is part of the Apodini open source project
//
// SPDX-FileCopyrightText: 2019-2021 Paul Schmiedmayer and the Apodini project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import Apodini
import ApodiniDatabase
import Shared

struct DictionaryComponent: Component {
    var language: Language
    
    var entriesString: String {
        switch language {
        case .german:
            return "eintraege"
        case .english:
            return "entries"
        }
    }
    
    var favoritesString: String {
        switch language {
        case .german:
            return "favoriten"
        case .english:
            return "favorites"
        }
    }
    
    var content: some Component {
        Group(entriesString) {
            Delete<DictionaryEntry>()
            ReadOne<DictionaryEntry>()
            SearchDictionaryHandler()
        }
        Group(favoritesString) {
            DictionaryFavoritesComponent()
        }
    }
}
