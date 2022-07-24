//
// This source file is part of the Apodini open source project
//
// SPDX-FileCopyrightText: 2019-2021 Paul Schmiedmayer and the Apodini project authors (see CONTRIBUTORS.md) <paul.schmiedmayer@tum.de>
//
// SPDX-License-Identifier: MIT
//

import Foundation
import Apodini

struct LectureComponent: Component {
    let language: Language
    
    @PathParameter var lectureId: Int
    
    var imagePathString: String {
        switch language {
        case .german:
            return "bilder"
        case .english:
            return "images"
        }
    }
    
    var favoritesString: String {
        switch language {
        case .german:
            return "favoriten"
        case .english:
            return "favorites"
        }
    }
    
    var content: some Component {
        Group($lectureId, imagePathString) {
            ImageComponent(lectureId: $lectureId)
        }
        Group(favoritesString) {
            GetFavoriteLecturesHandler()
        }
    }
}
