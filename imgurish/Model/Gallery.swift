//
//  Gallery.swift
//  imgurish
//
//  Created by Gawish on 06/11/2020.
//

import Foundation

struct Gallery: Codable {
    let data: [Post]
}

enum GallerySection {
    case hot
    case top
    case user
}

enum GallerySort {
    case viral
    case top
    case time
    case rising
}

enum GalleryWindow {
    case day
    case week
    case month
    case year
}
