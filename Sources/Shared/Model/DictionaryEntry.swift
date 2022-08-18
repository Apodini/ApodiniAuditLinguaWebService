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

public final class DictionaryEntry: DatabaseModel {
    public static let schema: String = "dictionaryentries"
    
    @ID(custom: "entryid")
    public var id: Int?
    @Field(key: "word")
    public var word: String
    @Field(key: "creation_date")
    public var creationDate: Date
    
    public init(_ id: Int, _ word: String, _ creationDate: Date = .default) {
        self.id = id
        self.word = word
        self.creationDate = creationDate
    }
    
    public init() {}
    
    public func update(_ object: DictionaryEntry) {
        self.id = object.id
        self.word = object.word
        self.creationDate = object.creationDate
    }
}
