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

struct GetDictionaryEntryHandler<D: DictionaryEntry>: Handler {
    @Binding var entryId: Int
    
    @Apodini.Environment(\.database) private var database: FluentKit.Database
    
    func handle() throws -> EventLoopFuture<Status> {
        D.find(entryId, on: database)
            .flatMap { ($0 ?? PrivateDictionaryEntry()).delete(on: database ) }
            .transform(to: .noContent)
    }
}
