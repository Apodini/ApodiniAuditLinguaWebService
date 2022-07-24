//
// This source file is part of the Apodini open source project
//
// SPDX-FileCopyrightText: 2019-2021 Paul Schmiedmayer and the Apodini project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import ApodiniAuthorization
import Apodini

public struct MockCredentials<State>: Authenticatable {
    var username: String
    var password: String

    var email: String
    var state: State

    var someState = true
}

public struct MockCredentialVerifier<State>: AuthenticationVerifier {
    let expectedPassword: String
    let state: State

    @Throws(.unauthenticated)
    var unauthenticatedError

    public func initializeAndVerify(for authenticationInfo: (username: String, password: String)) throws -> MockCredentials<State> {
        let instance = MockCredentials(
            username: authenticationInfo.username,
            password: authenticationInfo.password,
            email: "test@example.de",
            state: state
        )
        if expectedPassword != instance.password {
            throw unauthenticatedError
        }
        return instance
    }
    
    public init(expectedPassword: String, state: State) {
        self.expectedPassword = expectedPassword
        self.state = state
    }
}
