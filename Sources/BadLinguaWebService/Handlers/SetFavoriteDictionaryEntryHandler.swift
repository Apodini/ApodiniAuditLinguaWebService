//
// This source file is part of the Apodini open source project
//
// SPDX-FileCopyrightText: 2019-2021 Paul Schmiedmayer and the Apodini project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import Apodini
import Shared
import FluentKit
import ApodiniDatabase
import ApodiniNetworking

struct SetFavoriteDictionaryEntryHandler: Handler {
    @Binding var entryId: Int
    
    func handle() throws -> DictionaryEntry {
        DictionaryEntry(0, "example")
    }
    
    var metadata: AnyHandlerMetadata {
        Operation(.create)
    }
}
