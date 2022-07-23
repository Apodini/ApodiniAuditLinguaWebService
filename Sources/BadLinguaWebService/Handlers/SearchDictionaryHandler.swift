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

struct SearchDictionaryHandler: Handler {
    
    // Fictional query parameters
    @Parameter(.http(.query)) var entriesPerPage: Int
    @Parameter(.http(.query)) var pageNumber: Int
    @Parameter(.http(.query)) var search: String
    @Parameter(.http(.query)) var after: String
    @Parameter(.http(.query)) var before: String
    @Parameter(.http(.query)) var minLength: Int
    @Parameter(.http(.query)) var maxLength: Int
    @Parameter(.http(.query)) var prefix: String
    @Parameter(.http(.query)) var suffix: String
    @Parameter(.http(.query)) var wordType: String
    @Parameter(.http(.query)) var includeDefinition: Bool
    @Parameter(.http(.query)) var includeEtymology: String
    
    
    func handle() throws -> [DictionaryEntry] {
        [DictionaryEntry("Hello")]
    }
}
