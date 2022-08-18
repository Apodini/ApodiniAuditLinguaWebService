//
// This source file is part of the Apodini open source project
// 
// SPDX-FileCopyrightText: 2021 Paul Schmiedmayer and the project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import XCTest
@testable import BadLinguaWebService
@testable import ImprovedLinguaWebService
@testable import Apodini
import XCTApodiniNetworking
import ApodiniHTTPProtocol
import XCTApodini

struct RESTResponse: Codable {
    var data: String
    var links: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case data
        case links = "_links"
    }
}

/// Checks that the WebService's output is correct, such as correct status code upon unauthorized access.
/// We use the ``ImprovedLinguaWebService`` here.
final class EnforcableBPTests: XCTApodiniTest {
    let authHeaders: HTTPHeaders = {
        var headers = HTTPHeaders()
        let authorization = Authorization(.basic(username: "user", password: "123456")).untyped()
        headers.add(name: "Authorization", value: authorization.value)
        return headers
    }()

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        try ImprovedLinguaWebService().start(app: app)
    }
    
    func testUnauthorizedStatus() throws {
        try app.testable().test(.GET, "/en/lectures/0/images/0") { response in
            XCTAssertEqual(response.status, .unauthorized)
        }
    }
    
    func testHATEOAS() throws {
        // Test that the root points to all the endpoints
        try app.testable().test(.GET, "/") { response in
            XCTAssertEqual(try response.bodyStorage.getFullBodyData(decodedAs: [String: [String: String]].self)["_links"], [
                "en_dictionary_entries" : "http://localhost/en/dictionary/entries",
                "en_lectures_favorites" : "http://localhost/en/lectures/favorites",
                "de_lektionen_bilder" : "http://localhost/de/lektionen/{lectureId}/bilder/{imageId}",
                "de_lektionen_favoriten" : "http://localhost/de/lektionen/favoriten",
                "de_woerterbuch_eintraege" : "http://localhost/de/woerterbuch/eintraege",
                "en_lectures_images" : "http://localhost/en/lectures/{lectureId}/images/{imageId}"
            ])
        }
        
        // Test that the endpoints at least contain a self link
        try app.testable().test(.GET, "/en/lectures/favorites", headers: authHeaders) { response in
            XCTAssertEqual(try response.bodyStorage.getFullBodyData(decodedAs: RESTResponse.self).links, [
                "self" : "http://localhost/en/lectures/favorites"
            ])
        }
    }
    
    func testDeleteReturnValue() throws {
        // Test that the endpoints at least contain a self link
        try app.testable().test(.GET, "/en/dictionary/entries/0", headers: authHeaders) { response in
            print(response.bodyStorage.getFullBodyDataAsString())
            XCTAssertEqual(try response.bodyStorage.getFullBodyData(decodedAs: RESTResponse.self).links, [
                "self" : "http://localhost/en/lectures/favorites"
            ])
        }
    }
}
