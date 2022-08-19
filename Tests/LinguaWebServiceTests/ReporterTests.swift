//
// This source file is part of the Apodini open source project
//
// SPDX-FileCopyrightText: 2021 Paul Schmiedmayer and the project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
@testable import ApodiniAudit
import XCTApodini
@testable import BadLinguaWebService

final class ReporterTests: XCTApodiniTest {
    func testReportFormat() throws {
        let runcommandtype = AuditRunCommand<BadLinguaWebService>.self
        var runcommand = runcommandtype.init()

        let report = try CheckableBPTests.getReportForAuditRunCommand(&runcommand)
        XCTAssertEqual(
            Reporter.generateReportString(report, "BadLinguaWebService"),
            """

            ====================================
            ApodiniAudit Report
            ====================================

            /de/holeFavorisierteLektionen
              GetFavoriteLecturesHandler
                The path segment holeFavorisierteLektionen contains one or more uppercase letters

            /de/lektionen/{lectureId}/bild/{imageId}
              GetImageHandler
                The path segment "de" is too short
                Found non-plural word "lektionen" in front of a parameter
                Found non-plural word "bild" in front of a parameter

            /de/woerterbuch/eintraege/{entryId}
              DeleteDictionaryEntryHandler
                Found non-plural word "eintraege" in front of a parameter

            /en/dictionary/entries
              SearchDictionaryHandler
                This handler has too many parameters: 12

            /en/dictionary/entries/{entryId}
              DeleteDictionaryEntryHandler
                No resource is returned from DELETE Handler
                  Consider using Apodini's standard delete handler!

            /en/favorites/{entryId}
              SetFavoriteDictionaryEntryHandler
                DictionaryEntries may not be served from this Endpoint!
                  Consider moving it below one of these paths: /en/dictionary, /de/woerterbuch

            /en/getFavoriteLectures
              GetFavoriteLecturesHandler
                The path segment getFavoriteLectures contains one or more uppercase letters
                The path segment getFavoriteLectures contains one or more CRUD verbs

            /en/lectures/{lectureId}/image/{imageId}
              GetImageHandler
                This handler returns blob data
                  You can use ETags to enable caching for this endpoint!
                The path segment "en" is too short
                Found non-plural word "image" in front of a parameter
            
            
            """
        )
    }
}
