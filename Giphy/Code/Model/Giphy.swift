//
//  File.swift
//  Giphy
//
//  Created by Denis Romashov on 3/28/19.
//  Copyright © 2019 Denis Romashov. All rights reserved.
//

import Foundation
import ObjectMapper

struct Giphy {
    var data =  [GiphyData]()
    var pagination: GiphyPagination?

    init(json: [String: Any]) {
        let dataResponse = json["data"] as? [[String: Any]] ?? []
        dataResponse.forEach({ (item) in
            if let giphyData = Mapper<GiphyData>().map(JSON: item) {
                data.append(giphyData)
            }
        })

        let paginationResponse = json["pagination"] as? [String: Any] ?? [:]
        pagination = Mapper<GiphyPagination>().map(JSON: paginationResponse)
    }
}

struct GiphyData: Mappable {
    var id: Int = 0
    var image: GiphyImage?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        let images = map.JSON["images"] as? [String: Any] ?? [:]
        let fixedWidthImage = images["fixed_width"] as? [String: Any] ?? [:]
        image = Mapper<GiphyImage>().map(JSON: fixedWidthImage)
    }
}

struct GiphyPagination: Mappable {
    var totalCount: Int = 0
    var offset: Int = 0
    var count: Int = 0

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        totalCount <- map["total_count"]
        offset <- map["offset"]
        count <- map["count"]
    }
}
