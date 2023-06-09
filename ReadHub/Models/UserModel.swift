//
//  UserModel.swift
//  ReadHub
//
//  Created by Chinmay Bansal on 3/29/23.
//

import Foundation
import ParseSwift

struct User: ParseUser {
    // These are required by `ParseObject`.
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    // These are required by `ParseUser`.
    var username: String?
    var email: String?
    var emailVerified: Bool?
    var password: String?
    var authData: [String: [String: String]?]?
    var followingIds: [String]? //Stores users object ids

    // Your custom properties.
    // var customKey: String?
    var following: [String]? {
            get { return followingIds }
            set { followingIds = newValue }
        }
}


