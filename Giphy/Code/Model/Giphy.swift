//
//  File.swift
//  Giphy
//
//  Created by Denis Romashov on 3/28/19.
//  Copyright © 2019 Denis Romashov. All rights reserved.
//

import Foundation
import ObjectMapper

struct Giphy: Mappable {
    var id:Int = 0
    var image: GiphyImage?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        let images = map.JSON["images"] as? [String : Any] ?? [:]
        let fixedWidthImage = images["fixed_width"] as? [String : Any] ?? [:]
        image = Mapper<GiphyImage>().map(JSON: fixedWidthImage)
        print(image)
//        image <-
    }
    

}
