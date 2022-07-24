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

struct GetImageHandler: Handler {
    @Binding var lectureId: Int
    @Binding var imageId: Int
    
    func handle() throws -> Blob {
        try getBlob(for: "\(imageId)", withExtension: "jpeg", mediaType: .image(.jpeg))
    }
}
