//
//  AlbumEndpoint.swift
//  imgurish
//
//  Created by Gawish on 18/11/2020.
//

import Foundation

enum AlbumEndpoint {
    case favorite(id: String)
}

extension AlbumEndpoint: EndpointProtocol {
    
    var link: String {
        switch self {
        case .favorite(let id):
            return "\(CONSTANTS.BASELINK)/album/\(id)/favorite"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .favorite(_):
            return .POST
        }
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

