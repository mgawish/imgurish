//
//  ImageLoader.swift
//  imgurish
//
//  Created by Gawish on 10/11/2020.
//  Built using the following tutorial: https://www.vadimbulavin.com/asynchronous-swiftui-image-loading-from-url-with-combine-and-swift/
//

import Foundation
import UIKit
import Combine

class ImageLoader: ObservableObject {
    var url: URL?
    @Published var image: UIImage?
    var cancellable: AnyCancellable?
    var cache: ImageCache?
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    private(set) var isLoading = false

    
    init(_ urlString: String, cache: ImageCache) {
        self.url = URL(string: urlString)
        self.cache = cache
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        guard !isLoading else { return }

        guard let url = url else {
            print("Invalid image url")
            return
        }
        
        if let image = cache?[url] {
            self.image = image
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .subscribe(on: Self.imageProcessingQueue)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: return
                case .failure(let error): print("error \(error)")
                }
            }, receiveValue: { data in
                self.image = UIImage(data: data)
                self.cache(self.image)
            })
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    private func cache(_ image: UIImage?) {
        guard let url = url else {
            print("Invalid image url")
            return
        }
        image.map { cache?[url] = $0 }
    }
}
