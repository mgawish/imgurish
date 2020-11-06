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
        guard let published: AnyPublisher<Gallery, Error> = try? publisher.publish(endpoint: GalleryEndpoint.list) else {
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
