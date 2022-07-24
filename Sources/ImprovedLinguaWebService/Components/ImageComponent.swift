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

struct ImageComponent: Component {
    @Binding var lectureId: Int
    
    @PathParameter var imageId: Int
    
    var content: some Component {
        Group($imageId) {
            GetImageHandler(lectureId: $lectureId, imageId: $imageId)
                .metadata {
                    SelectBestPractices(.exclude, EncourageETags.self)
                }
        }
    }
}
