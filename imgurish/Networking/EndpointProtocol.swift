//
//  EndpointProtocol.swift
//  imgurish
//
//  Created by Gawish on 05/11/2020.
//

import Foundation

protocol EndpointProtocol {
    var link: String { get }
    var httpMethod: HttpMethod { get }
    var queryParams: [URLQueryItem] { get }
    var bodyParams: [String: Any] { get }
    var headers: [String: Any] { get }
    
}
