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
struct ImprovedLinguaWebService: Apodini.WebService {
    var content: some Component {
        Group("Hello") {
            Text("Hi")
        }
    }
    
    var configuration: Configuration {
        REST {
            APIAuditor()
        }
    }
}