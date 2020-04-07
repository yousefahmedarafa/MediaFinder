//
//  User.swift
//  Registration App
//
//  Created by Yousef Arafa on 2/12/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import Foundation

enum Gender: String, Codable {
    case Male
    case Female
}

struct User: Codable {
    
    var name: String!
    var email: String!
    var password: String!
    var address: String!
    var phone: String!
    var gender: Gender!
    var isLoggedIn: Bool!
    
}
