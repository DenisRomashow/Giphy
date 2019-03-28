//
//  APIConfigs.swift
//  Giphy
//
//  Created by Denis Romashov on 3/28/19.
//  Copyright © 2019 Denis Romashov. All rights reserved.
//

import UIKit

struct Constants {
    static let appID = Bundle.main.bundleIdentifier!
}

public struct APIConfigs {

    static var timeoutInterval: Double {
        return 30
    }

    public var uuid: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }

    static var apiPrefix: String {
        return "https://api.giphy.com/v1/"
    }

    static var apiKey: String {
        return "FjfZ2BL5R2FZG8uYk73Ww453OBDvaP5y"
    }
    
    static var header: [String: String] {
//        return ["Authorization": Session.accessToken ?? ""],
        return ["Content-Type": "text/json"]
    }
    
    static func request(part: String) -> String {
        return "\(apiPrefix)\(part)"
    }
}
