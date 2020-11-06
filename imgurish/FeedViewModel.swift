//
//  NetworkLayer.swift
//  imgurish
//
//  Created by Gawish on 05/11/2020.
//

import Foundation
import Combine

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    let publisher = GenericPublisher()
    var cancellable: Cancellable?


    init() {
        fetchData()
    }
    
    func fetchData() {
        print("fetchData")
        let endpoint = GalleryEndpoint.list(category: .hot, sort: .top, window: .week, page: 1)
        guard let published: AnyPublisher<Gallery, Error> = try? publisher.publish(endpoint: endpoint) else {
            return
        }
        
        cancellable = published
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: print("finished")
                case .failure(let error): print("error \(error)")
                }
            } receiveValue: { gallery in
                self.posts = gallery.data
            }
    }
}
