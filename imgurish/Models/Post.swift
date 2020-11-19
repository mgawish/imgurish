//
//  Post.swift
//  imgurish
//
//  Created by Gawish on 06/11/2020.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: String
    let title: String
    let ups: Int
    let downs: Int
    let points: Int
    let images: [PostImage]?
    let tags: [PostTag]
    var favorite: Bool
    var vote: String?
    
    var firstImage: PostImage? {
        return images?.first
    }
    
    var isValid: Bool {
        if let image = firstImage {
            return image.type == "image/jpeg"
        } else {
            return false
        }
    }
    
    var voteType: GalleryVote {
        GalleryVote(rawValue: vote ?? "") ?? .veto
    }
}

class PostImage: Codable {
    let id: String
    //let title: String
    let link: String
    let type: String
    //let width: Int
    //let height: Int
}

class PostTag: Codable, Identifiable {
    var id = UUID()
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
}
