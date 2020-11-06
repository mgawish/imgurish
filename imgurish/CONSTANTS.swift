//
//  Constants.swift
//  imgurish
//
//  Created by Gawish on 06/11/2020.
//

import Foundation

struct CONSTANTS {
    static let BASELINK: String = "https://api.imgur.com/3"
    static let COMMON_HEADERS: [String: String] = [
        "Authorization": "Client-ID \(AppKeys.shared.clientId)"
    ]
}
