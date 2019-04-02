//
//  Requester.swift
//  Giphy
//
//  Created by Denis Romashov on 3/28/19.
//  Copyright © 2019 Denis Romashov. All rights reserved.
//

import Foundation
import Alamofire
import SystemConfiguration

typealias EmptyBlock = (() -> Void)
typealias ResponseBlock = (([String: Any]) -> Void)

class Requester: NSObject {

    static let shared = Requester()
    var sessionManager = Alamofire.SessionManager()
    private var reachabilityManager: NetworkReachabilityManager?

    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = APIConfigs.timeoutInterval
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }

    private static var manager: Alamofire.SessionManager {
        return shared.sessionManager
    }

    class func sendRequest(request: String, method: Alamofire.HTTPMethod, parameters: Parameters? = nil, headers: Bool = false, completion: @escaping ResponseBlock, failure: EmptyBlock? = nil) {
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        let checkHeaders = headers ? APIConfigs.header : nil

        manager.request(request, method: method, parameters: parameters, encoding: encoding, headers: checkHeaders).responseJSON(completionHandler: { response in
            guard let dictionary = response.result.value as? [String: AnyObject] else { return }
            completion(dictionary)
        })
    }

}
