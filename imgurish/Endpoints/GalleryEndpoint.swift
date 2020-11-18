//
//  GalleryEndpoint.swift
//  imgurish
//
//  Created by Gawish on 05/11/2020.
//

import Foundation
 
enum GalleryEndpoint {
    case list(category: GallerySection, sort: GallerySort, window: GalleryWindow, page: Int)
}

extension GalleryEndpoint: EndpointProtocol {
    var link: String {
        switch self {
        case .list(let category, let sort, let window, let page):
            return "\(CONSTANTS.BASELINK)/gallery/\(category)/\(sort)/\(window)/\(page)"
        }
    }
    
    var httpMethod: HttpMethod {
        return .GET
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
