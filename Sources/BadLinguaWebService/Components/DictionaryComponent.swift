//
// This source file is part of the Apodini open source project
//
// SPDX-FileCopyrightText: 2019-2021 Paul Schmiedmayer and the Apodini project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import Apodini

struct DictionaryComponent: Component {
    var language: Language
    
    var entriesString: String {
        switch language {
        case .german:
            return "entries"
        case .english:
            return "eintraege"
        }
    }
    
    var personalString: String {
        switch language {
        case .english:
            return "personal"
        case .german:
            return "persoenlich"
        }
    }
    
    var content: some Component {
        Group(entriesString) {
            DictionaryEntryStore(personalStore: false)
        }
        Group(personalString, entriesString) {
            DictionaryEntryStore(personalStore: true)
        }
    }
}
