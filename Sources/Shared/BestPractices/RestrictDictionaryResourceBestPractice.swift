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

class RestrictDictionaryEntryResourceBestPractice: BestPractice {
    static var scope: BestPracticeScopes = .rest
    static var category: BestPracticeCategories = .returnType
    static var priority: Priority = .high
    
    private var checkedHandlerNames = [String]()

    var configuration = RestrictDictionaryEntryResource(allowedPrefixes: [])
    
    func check(into audit: Audit, _ app: Application) {
        let handlerName = audit.endpoint[HandlerReflectiveName.self].rawValue
        guard !checkedHandlerNames.contains(handlerName) else {
            return
        }
        
        checkedHandlerNames.append(handlerName)
        
        // Check the return type of the Endpoint
        let typeString = String(describing: audit.endpoint[HandleReturnType.self].type)
        guard typeString.contains("DictionaryEntry") else {
            // If the return type is not DictionaryEntry, we have nothing to check
            return
        }

        // Extract the String version of the Endpoint's path
        let pathString = audit.endpoint.absolutePath.map { segment in
                segment.description
            }
            .joined(separator: "/")
        
        // Check whether the Endpoint's path starts with one of the allowed paths
        let hasValidPrefix = configuration.allowedPrefixes.contains {
            pathString.hasPrefix($0)
        }
        
        if !hasValidPrefix {
            // We record a finding if the path does not start with an allowed prefix
            audit.recordFinding(DictionaryEntryResourceFinding.dictionaryEntryAtIllegalLocation(allowedPrefixes: configuration.allowedPrefixes))
        }
    }
    
    required init() { }
    
    init(configuration: RestrictDictionaryEntryResource) {
        self.configuration = configuration
    }
}

enum DictionaryEntryResourceFinding: Finding {
    case dictionaryEntryAtIllegalLocation(allowedPrefixes: [String])
    
    var diagnosis: String {
        switch self {
        case .dictionaryEntryAtIllegalLocation:
            return "DictionaryEntries may not be served from this Endpoint!"
        }
    }
    
    var suggestion: String? {
        switch self {
        case .dictionaryEntryAtIllegalLocation(let allowedPrefixes):
            return "Consider moving it below one of these paths: \(allowedPrefixes.joined(separator: ", "))"
        }
    }
}

public struct RestrictDictionaryEntryResource: BestPracticeConfiguration {
    public func configure() -> BestPractice {
        RestrictDictionaryEntryResourceBestPractice(configuration: self)
    }
    
    var allowedPrefixes: [String]
    
    public init(allowedPrefixes: [String]) {
        self.allowedPrefixes = allowedPrefixes
    }
}
