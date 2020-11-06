//
//  ReadConfig.swift
//  imgurish
//
//  Created by Gawish on 06/11/2020.
//

import Foundation

class AppKeys {
    static let shared = AppKeys()
    
    var clientId = ""
    var clientSecret = ""
    
    init() {
        guard let filePath = Bundle.main.path(forResource: "AppKeys", ofType: "plist") else {
            fatalError("Config file doesnt exist")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        
        clientId = plist?["clientId"] as? String ?? ""
        clientSecret = plist?["clientSecret"] as? String ?? ""
    }
}
