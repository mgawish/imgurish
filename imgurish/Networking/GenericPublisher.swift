//
//  PublisherExecutrer.swift
//  imgurish
//
//  Created by Gawish on 06/11/2020.
//

import Foundation
import Combine

class GenericPublisher {
    func publish<T:Decodable>(endpoint: EndpointProtocol) throws -> AnyPublisher<T, Error> {
        guard let url = URL(string: endpoint.link) else {
            throw NetworkError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        endpoint.headers.forEach { key, value in
            urlRequest.addValue(value as? String ?? "", forHTTPHeaderField: key)
        }
        
        CONSTANTS.COMMON_HEADERS.forEach{ key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
