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

public protocol DictionaryEntry: DatabaseModel {
    init(_ word: String)
}

public final class PublicDictionaryEntry: DictionaryEntry {
    public static let schema: String = "publicentries"
    
    @ID
    public var id: Int?
    @Field(key: "word")
    public var word: String
    
    public init(_ word: String) {
        self.word = word
    }
    
    public init() {}
    
    public func update(_ object: PublicDictionaryEntry) {
        if object.id != nil {
            self.id = object.id
        }
        self.word = object.word
    }
}

public final class PrivateDictionaryEntry: DictionaryEntry {
    public convenience init(_ word: String) {
        self.init(word, .default)
    }
    
    public static let schema: String = "privateentries"
    
    @ID
    public var id: Int?
    @Field(key: "word")
    public var word: String
    @Field(key: "creation_date")
    public var creationDate: Date
    
    public init(_ word: String, _ creationDate: Date) {
        self.word = word
        self.creationDate = creationDate
    }
    
    public init() {}
    
    public func update(_ object: PrivateDictionaryEntry) {
        if object.id != nil {
            self.id = object.id
        }
        self.word = object.word
        self.creationDate = object.creationDate
    }
}
