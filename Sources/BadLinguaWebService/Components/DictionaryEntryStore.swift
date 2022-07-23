//
// This source file is part of the Apodini open source project
//
// SPDX-FileCopyrightText: 2019-2021 Paul Schmiedmayer and the Apodini project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import Apodini

struct DictionaryEntryStore: Component {
    @PathParameter var entryId: Int
    
    var personalStore: Bool
    
    var content: some Component {
        Group($entryId) {
            if personalStore {
                DeletePrivateDictionaryEntryHandler(entryId: $entryId)
            }
            GetDictionaryEntryHandler()
        }
        SearchDictionaryHandler()
    }
}
