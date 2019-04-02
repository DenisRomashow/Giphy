//
//  GiphyImage.swift
//  Giphy
//
//  Created by Denis Romashov on 3/28/19.
//  Copyright © 2019 Denis Romashov. All rights reserved.
//

import Foundation
import ObjectMapper

struct GiphyImage: Mappable {
    var url = ""
    var mp4 = ""

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        url <- map["url"]
        mp4 <- map["mp4"]
    }

}
