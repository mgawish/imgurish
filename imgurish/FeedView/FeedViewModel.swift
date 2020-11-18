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
    @Published var selectedPicker = 1 {
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
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished: print("finished")
                case .failure(let error): print("error \(error)")
                }
            } receiveValue: { gallery in
                self.posts = gallery.data.filter({ $0.isValid })
            }
    }
    
    func onTapUp(_ post: Post) {
        
    }
    
    func onTapDown(_ post: Post) {
        
    }
    
    func onTapComment(_ post: Post) {
        
    }
    
    func onTapFav(_ post: Post) {
        print("onTapFav")
        let endpoint = AlbumEndpoint.favorite(id: post.id)
        guard let published: AnyPublisher<FavoriteResponse, Error> = try? publisher.publish(endpoint: endpoint) else {
            return
        }
        
        cancellable = published
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished: print("finished")
                case .failure(let error): print("error \(error)")
                }
            } receiveValue: { data in
                if let index = self.posts.firstIndex(where: { $0.id == post.id }) {
                    self.posts[index].favorite = data.isFavorite
                }
            }
    }
    
    func onTapShare(_ post: Post) {
        
    }
}
