//
//  UserViewModel.swift
//  imgurish
//
//  Created by Gawish on 15/11/2020.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    let publisher = GenericPublisher()
    var cancellable: Cancellable?
    
    @Published var user: User?
    
    init() {
        fetchUserDetails()
    }
    
    func fetchUserDetails() {
        print("fetchUserDetails")
        let endpoint = UserEndpoint.details
        guard let published: AnyPublisher<UserData, Error> = try? publisher.publish(endpoint: endpoint) else {
            return
        }
        
        cancellable = published
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished: print("finished")
                case .failure(let error): print("error \(error)")
                }
            } receiveValue: { userData in
                self.user = userData.data
            }

    }
}
