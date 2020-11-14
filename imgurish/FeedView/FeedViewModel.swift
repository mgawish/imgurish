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
    @Published var selectedPicker = 0 {
        didSet {
            switch selectedPicker {
            case 0: fetchData(section: .hot)
            case 1: fetchData(section: .top)
            default: fetchData(section: .hot)
            }
        }
    }
    let publisher = GenericPublisher()
    var cancellable: Cancellable?

    init() {
       fetchData()
    }
    
    func fetchData(section: GallerySection = .hot) {
        print("fetchData \(section)")
        posts = []
        let endpoint = GalleryEndpoint.list(category: section, sort: .top, window: .week, page: 1)
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
                self.posts = gallery.data.filter({ $0.isValid }) //Array(gallery.data.prefix(3))
            }
    }
}
