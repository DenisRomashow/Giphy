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

class Requester: NSObject {
    
    static let shared = Requester()
    var sessionManager = Alamofire.SessionManager()
    private var reachabilityManager: NetworkReachabilityManager? = nil
    
    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = APIConfigs.timeoutInterval
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    private static var manager: Alamofire.SessionManager {
        return shared.sessionManager
    }
    
    class func sendRequest(request requestPath: String, method: Alamofire.HTTPMethod, parameters: Parameters? = nil, headers: Bool = false, completion: @escaping([String: Any]) -> Void) {
        let encoding: ParameterEncoding = URLEncoding.httpBody
        let checkHeaders = APIConfigs.header //headers ? APIConfigs.header : nil
        
        var request = URLRequest(url: URL(string: requestPath)!)
        request.httpMethod = method.rawValue
        request.setValue("text/json", forHTTPHeaderField: "Content-Type")
        let pjson = parameters?.json
        let data = (pjson?.data(using: .utf8))! as Data
        
        request.httpBody = data
        
        manager.request(request).responseJSON { (response) in
            guard let dictionary = response.result.value as? [String : AnyObject] else { return }
            
//            ResponseValidator.checkResponse(response: response, completion: { response in
                completion(dictionary)
//            })
        }
    }
    
}
