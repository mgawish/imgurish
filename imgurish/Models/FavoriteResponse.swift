//
//  FavoriteResponse.swift
//  imgurish
//
//  Created by Gawish on 18/11/2020.
//

import Foundation

struct FavoriteResponse: Codable {
    var data: String
    var status: Int
    
    var isFavorite: Bool {
        data == "favorited"
    }
}
