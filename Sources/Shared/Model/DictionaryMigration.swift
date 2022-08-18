//
// This source file is part of the Apodini open source project
//
// SPDX-FileCopyrightText: 2019-2021 Paul Schmiedmayer and the Apodini project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import FluentKit

public struct DictionaryMigration: Migration {
    public func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.eventLoop.makeSucceededVoidFuture()
    }
    
    public func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("dictionaryentries")
            .field("entryid", .int, .identifier(auto: false))
            .field("word", .string, .required)
            .field("creation_date", .date, .required)
            .create()
            .flatMap {
                database.transaction { db in
                    let entry = DictionaryEntry(0, "moin")
                    return entry.save(on: db)
                }
            }
    }
    
    public init() { }
}

