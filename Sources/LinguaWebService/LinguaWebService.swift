//
// This source file is part of the Apodini open source project
//
// SPDX-FileCopyrightText: 2019-2021 Paul Schmiedmayer and the Apodini project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Apodini
import ApodiniHTTP
import ApodiniREST
import ApodiniAudit
import ArgumentParser


@main
struct LinguaWebService: Apodini.WebService {
    @Option(help: "Use the improved version of the Lingua Web Service")
    var useImprovedVersion: Bool = false
    
    var content: some Component {
        if useImprovedVersion {
            improvedContent
        } else {
            badContent
        }
    }
    
    @ComponentBuilder static var badContent: some Component {
        Text("Hi")
    }
    
    @ComponentBuilder static var improvedContent: some Component {
        Text("Ho")
    }
    
    var configuration: Configuration {
        REST {
            if useImprovedVersion {
                improvedAuditConfiguration
            } else {
                badAuditConfiguration
            }
        }
    }
    
    static var badAuditConfiguration = APIAuditor()
    static var improvedAuditConfiguration = APIAuditor()
}
