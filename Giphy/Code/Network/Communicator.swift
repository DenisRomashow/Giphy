//
//  Communicator.swift
//  Giphy
//
//  Created by Denis Romashov on 3/28/19.
//  Copyright © 2019 Denis Romashov. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class Communicator: NSObject {
    private class func sendRequest(request: String, method: Alamofire.HTTPMethod, parameters: Parameters? = nil, headers: Bool = false, completion: @escaping([String: Any]) -> Void, failure: EmptyBlock? = nil) {
        Requester.sendRequest(request: request, method: method, parameters: parameters, headers: headers, completion: completion, failure: failure)
    }

    class func gifs(search: String, page: Int = 1, completion: @escaping ((Giphy) -> Void)) {
        let request = APIConfigs.request(part: "gifs/search")
        let parameters: [String: Any] = ["api_key": APIConfigs.apiKey,
                                         "q": search,
                                         "limit" : APIConfigs.limit,
                                         "offset" : page]
        sendRequest(request: request, method: .get, parameters: parameters, completion: { (response) in
            let giphy = Giphy(json: response)
            completion(giphy)
        }, failure: { () in
            
        })
        
    }
}
