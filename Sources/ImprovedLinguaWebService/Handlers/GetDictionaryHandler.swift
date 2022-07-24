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

struct GetDictionaryEntryHandler: Handler {
    @Throws(.notFound, reason: "Could not find a dictionary entry with this ID.")
    var entryNotFound: ApodiniError
    
    @Binding var entryId: Int
    
    @Apodini.Environment(\.database) private var database: FluentKit.Database
    
    func handle() throws -> EventLoopFuture<DictionaryEntry> {
        DictionaryEntry.find(entryId, on: database)
            .unwrap(orError: entryNotFound)
    }
}
