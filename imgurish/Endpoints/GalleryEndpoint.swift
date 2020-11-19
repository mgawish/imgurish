//
//  GalleryEndpoint.swift
//  imgurish
//
//  Created by Gawish on 05/11/2020.
//

import Foundation
 
enum GalleryEndpoint {
    case list(category: GallerySection, sort: GallerySort, window: GalleryWindow, page: Int)
    case vote(id: String, vote: GalleryVote)
}

extension GalleryEndpoint: EndpointProtocol {
    var link: String {
        switch self {
        case .list(let category, let sort, let window, let page):
            return "\(CONSTANTS.BASELINK)/gallery/\(category)/\(sort)/\(window)/\(page)"
        case .vote(let id, let vote):
            return "\(CONSTANTS.BASELINK)/gallery/\(id)/vote/\(vote.rawValue)"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .list(_,_, _, _):
            return .GET
        case .vote:
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
