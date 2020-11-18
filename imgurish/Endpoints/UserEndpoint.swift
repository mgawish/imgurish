//
//  UserEndpoint.swift
//  imgurish
//
//  Created by Gawish on 15/11/2020.
//

import Foundation

enum UserEndpoint {
    case details
}

extension UserEndpoint: EndpointProtocol {
    var link: String {
        switch self {
        case .details:
            return "\(CONSTANTS.BASELINK)/account/me/settings"
        }
    }
    
    var httpMethod: HttpMethod {
        .GET
    }
    
    var queryParams: [URLQueryItem] {
        []
    }
    
    var bodyParams: [String : Any] {
        [:]
    }
    
    var headers: [String : Any] {
        [:]
    }
    
    
}
