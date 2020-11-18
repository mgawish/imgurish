//
//  User.swift
//  imgurish
//
//  Created by Gawish on 15/11/2020.
//

import Foundation

struct UserData: Codable {
    var data: User
}

struct User: Codable {
    var email: String
    var account_url: String
}
