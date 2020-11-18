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
        
        urlRequest.httpMethod = endpoint.httpMethod.rawValue

        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap({ data, response in
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 401:
                        throw NetworkError.unauthorized
                    default: break
                    }
                }
                return data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
