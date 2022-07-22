//
//  File.swift
//  
//
//  Created by Simon Bohnen on 7/22/22.
//

import Foundation
import Apodini
import ApodiniNetworkingHTTPSupport

public func getBlob(for file: String, withExtension ext: String, mediaType: HTTPMediaType? = nil) throws -> Blob {
    let url = Bundle.module.url(forResource: file, withExtension: ext)!
    let data = try Data(contentsOf: url)
    return Blob(data, type: mediaType)
}
