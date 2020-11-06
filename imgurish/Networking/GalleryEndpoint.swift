//
//  GalleryEndpoint.swift
//  imgurish
//
//  Created by Gawish on 05/11/2020.
//

import Foundation

enum GalleryEndpoint {
    case list
}

extension GalleryEndpoint: EndpointProtocol {
    var link: String {
        "\(CONSTANTS.BASELINK)/gallery/hot/viral/day/1"
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
