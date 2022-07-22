//
// This source file is part of the Apodini open source project
//
// SPDX-FileCopyrightText: 2019-2021 Paul Schmiedmayer and the Apodini project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import Apodini
import ApodiniAudit
import Shared

struct RestrictDictionaryResourceBestPractice: BestPractice {
    static var scope: BestPracticeScopes = .rest
    static var category: BestPracticeCategories = .parameters
    
    var configuration = ReasonableParameterCountConfiguration()
    
    func check(into audit: Audit, _ app: Application) {
        // Check the return type of the Endpoint
        guard audit.endpoint[HandleReturnType.self].type == DictionaryEntry.self else {
            // If the return type is not DictionaryEntry, we have nothing to check
            return
        }

        // Extract the String version of the Endpoint's path
        let pathString = "/" + audit.endpoint.absolutePath.map { segment in
                segment.description
            }
            .joined(separator: "/")
        
        // Check whether the Endpoint's path starts with one of the allowed paths
        let hasValidPrefix = configuration.allowedPrefixes.contains {
            pathString.hasPrefix($0)
        }
        
        if !hasValidPrefix {
            // We record a finding if the path does not start with an allowed prefix
            audit.recordFinding(DictionaryEntryResourceFinding.dictionaryEntryAtIllegalLocation(path: pathString))
        }
    }
}

enum DictionaryEntryResourceFinding: Finding {
    case dictionaryEntryAtIllegalLocation(path: String)
    
    var diagnosis: String {
        switch self {
        case .dictionaryEntryAtIllegalLocation(let path):
            return "This Endpoint has too many parameters: \(path)"
        }
    }
}

struct ReasonableParameterCountConfiguration: BestPracticeConfiguration {
    func configure() -> BestPractice {
        RestrictDictionaryResourceBestPractice(configuration: self)
    }
    
    var allowedPrefixes = ["dictionary"]
}
